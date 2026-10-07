import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _offline = ApiException(0, 'Pas de connexion internet.');
const _expired = ApiException(401, 'Votre session a expiré. Reconnectez-vous.');

/// Traduit une erreur Supabase (SQL, Auth, Storage, réseau) en [ApiException],
/// avec les mêmes statuts et messages que le contrat d'API.
ApiException apiExceptionFrom(Object error) {
  return switch (error) {
    ApiException() => error,
    TimeoutException() ||
    SocketException() ||
    HttpException() ||
    TlsException() ||
    http.ClientException() => _offline,
    // Photo locale effacée entre la prise de vue et l'envoi.
    FileSystemException() => const ApiException(
      422,
      'Photo introuvable, reprenez-la.',
    ),
    AuthRetryableFetchException() => _offline,
    PostgrestException() => _fromPostgrest(error),
    AuthSessionMissingException() => _expired,
    AuthException() => _fromAuth(error),
    StorageException() => _fromStorage(error),
    _ => ApiException(500, '$error'),
  };
}

ApiException _fromPostgrest(PostgrestException error) {
  final code = error.code ?? '';
  // Erreurs métier : SQLSTATE « MO » + statut HTTP, message en français.
  if (code.startsWith('MO')) {
    final status = int.tryParse(code.substring(2));
    if (status != null) return ApiException(status, error.message);
  }
  if (code == 'PGRST301' ||
      code == 'PGRST303' ||
      error.message.contains('JWT expired')) {
    return _expired;
  }
  return ApiException(500, error.message);
}

/// Dépôt de photo refusé : jamais le texte anglais du service.
ApiException _fromStorage(StorageException error) {
  final text = '${error.error ?? ''} ${error.message}'.toLowerCase();
  if (error.statusCode == '413' ||
      text.contains('too large') ||
      text.contains('maximum allowed size')) {
    return const ApiException(422, 'Photo trop lourde. Reprenez-la.');
  }
  if (error.statusCode == '415' || text.contains('mime')) {
    return const ApiException(422, 'Format de photo non accepté.');
  }
  return const ApiException(500, 'Envoi de la photo impossible. Réessayez.');
}

ApiException _fromAuth(AuthException error) {
  return switch (error.code) {
    'invalid_credentials' => const ApiException(
      422,
      'E-mail ou mot de passe incorrect.',
    ),
    'user_already_exists' || 'email_exists' => const ApiException(
      422,
      'Un compte existe déjà avec cet e-mail.',
    ),
    'weak_password' => const ApiException(422, 'Au moins 6 caractères.'),
    'email_address_invalid' ||
    'validation_failed' => const ApiException(422, 'Adresse e-mail invalide.'),
    'session_expired' ||
    'session_not_found' ||
    'refresh_token_not_found' => _expired,
    _ => ApiException(500, error.message),
  };
}
