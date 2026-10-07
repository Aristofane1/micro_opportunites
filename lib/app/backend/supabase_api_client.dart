import 'dart:io';
import 'dart:math';

import 'package:micro_opportunites/app/backend/supabase_errors.dart';
import 'package:micro_opportunites/app/backend/supabase_routes.dart';
import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _expired = ApiException(401, 'Votre session a expiré. Reconnectez-vous.');

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Adaptateur du port [ApiClient] vers Supabase : l'authentification passe
/// par Supabase Auth, les photos par Storage, tout le reste par une fonction
/// SQL (RPC) appelée en POST — jamais en GET : les RPC appliquent d'abord le
/// règlement des missions échues, elles écrivent.
class SupabaseApiClient implements ApiClient {
  SupabaseApiClient(this._client, {this.timeout = const Duration(seconds: 20)});

  final SupabaseClient _client;

  /// Dossier de la dernière pièce envoyée, réutilisé tant que les mêmes
  /// photos sont renvoyées (nouvelle tentative) : pas de copies orphelines.
  ({String key, String folder})? _kycFolder;

  /// Délai maximal de chaque appel réseau (RPC, Auth, téléversement).
  final Duration timeout;

  @override
  Future<Object?> get(String path, {Map<String, String>? query}) =>
      _send('GET', path, query: query ?? const {});

  @override
  Future<Object?> post(String path, {Object? body}) =>
      _send('POST', path, body: body);

  @override
  Future<Object?> delete(String path) => _send('DELETE', path);

  Future<Object?> _send(
    String method,
    String path, {
    Map<String, String> query = const {},
    Object? body,
  }) async {
    try {
      final json = body == null
          ? <String, Object?>{}
          : Map<String, Object?>.from(body as Map);
      return await _dispatch(method, path, query, json);
    } catch (error) {
      throw apiExceptionFrom(error);
    }
  }

  Future<Object?> _dispatch(
    String method,
    String path,
    Map<String, String> query,
    Map<String, Object?> body,
  ) async {
    if (method == 'POST') {
      switch (path) {
        case '/auth/login':
          return _login(body);
        case '/auth/signup':
          return _signup(body);
        case '/auth/logout':
          return _logout();
      }
    }
    final match = matchRoute(method, path);
    final rpc = match?.route.rpc;
    if (match == null || rpc == null) {
      throw ApiException(404, 'Route inconnue : $method $path');
    }
    // Toutes les RPC exigent un compte : sans session, inutile d'appeler le
    // réseau (et un lancement hors ligne sans session mène à l'onboarding).
    if (_client.auth.currentSession == null) throw _expired;
    if (method == 'POST' && path == '/auth/kyc') {
      body = await _uploadKyc(body);
    } else if (method == 'POST' &&
        match.route.pattern == '/assignments/:id/check-out') {
      body = await _uploadProofs(match.params['id']!, body);
    }
    return _rpc(rpc, match.route.args(match.params, query, body));
  }

  Future<Object?> _rpc(String name, Map<String, Object?> args) =>
      _timed(_client.rpc<Object?>(name, params: args));

  Future<Object?> _login(Map<String, Object?> body) async {
    await _timed(
      _client.auth.signInWithPassword(
        email: (body['email'] as String? ?? '').trim(),
        password: body['password'] as String? ?? '',
      ),
    );
    return _rpc('me', const {});
  }

  /// La session locale est effacée avant l'appel au serveur : un échec de
  /// celui-ci (hors ligne…) ne retient pas l'utilisateur connecté.
  Future<Object?> _logout() async {
    try {
      await _timed(_client.auth.signOut());
    } catch (_) {
      if (_client.auth.currentSession != null) rethrow;
    }
    return null;
  }

  /// Mêmes vérifications locales que le serveur, avant d'appeler Auth.
  Future<Object?> _signup(Map<String, Object?> body) async {
    final email = (body['email'] as String? ?? '').trim().toLowerCase();
    final password = body['password'] as String? ?? '';
    if (!_emailPattern.hasMatch(email)) {
      throw const ApiException(422, 'Adresse e-mail invalide.');
    }
    if (password.length < 6) {
      throw const ApiException(422, 'Au moins 6 caractères.');
    }
    await _timed(_client.auth.signUp(email: email, password: password));
    return _rpc('me', const {});
  }

  /// Téléverse les photos locales de la pièce dans `kyc/<uid>/<uuid>/` et
  /// remplace les chemins locaux par les chemins Storage (relatifs au bucket,
  /// préfixés par l'uid comme l'exige `submit_kyc`).
  Future<Map<String, Object?>> _uploadKyc(Map<String, Object?> body) async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) throw _expired;
    final key = [
      uid,
      body['frontPath'],
      body['backPath'],
      body['selfiePath'],
    ].join('|');
    final previous = _kycFolder;
    final folder = previous != null && previous.key == key
        ? previous.folder
        : '$uid/${_uuid()}';
    _kycFolder = (key: key, folder: folder);
    final result = Map<String, Object?>.of(body);
    for (final (field, name) in const [
      ('frontPath', 'front'),
      ('backPath', 'back'),
      ('selfiePath', 'selfie'),
    ]) {
      final local = body[field];
      if (local is String && local.isNotEmpty) {
        result[field] = await _upload('kyc', '$folder/$name.jpg', local);
      }
    }
    return result;
  }

  /// Téléverse les photos de fin dans `proofs/<assignmentId>/<uuid>/proof_<n>.jpg`
  /// (un dossier par envoi : un nouvel essai ne retombe jamais sur une
  /// ancienne photo). La policy ne regarde que le premier dossier, l'affectation.
  Future<Map<String, Object?>> _uploadProofs(
    String assignmentId,
    Map<String, Object?> body,
  ) async {
    final locals = (body['photos'] as List<Object?>? ?? const [])
        .whereType<String>()
        .toList();
    final folder = '$assignmentId/${_uuid()}';
    final stored = <String>[
      for (final (index, local) in locals.indexed)
        await _upload('proofs', '$folder/proof_${index + 1}.jpg', local),
    ];
    return {...body, 'photos': stored};
  }

  Future<String> _upload(String bucket, String name, String localPath) async {
    try {
      await _timed(
        _client.storage
            .from(bucket)
            .upload(
              name,
              File(localPath),
              fileOptions: FileOptions(
                contentType: localPath.toLowerCase().endsWith('.png')
                    ? 'image/png'
                    : 'image/jpeg',
              ),
            ),
      );
    } on StorageException catch (error) {
      // Déjà déposée lors d'un envoi précédent interrompu : on la garde.
      final duplicate = error.statusCode == '409' || error.error == 'Duplicate';
      if (duplicate) return name;
      // Dépôt de preuve refusé par la policy : l'affectation n'est pas en cours.
      if (bucket == 'proofs' && error.statusCode == '403') {
        throw const ApiException(409, 'Faites d’abord votre check-in.');
      }
      rethrow;
    }
    return name;
  }

  Future<T> _timed<T>(Future<T> call) => call.timeout(timeout);
}

/// Identifiant aléatoire au format UUID v4.
String _uuid() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
