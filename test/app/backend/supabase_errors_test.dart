import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:micro_opportunites/app/backend/supabase_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  void expectApi(Object error, int status, String message) {
    final result = apiExceptionFrom(error);
    expect(result.statusCode, status);
    expect(result.message, message);
  }

  test('erreur métier SQL MO4xx → ApiException(4xx, message)', () {
    expectApi(
      const PostgrestException(
        message: 'Plus de place libre sur cette mission.',
        code: 'MO409',
      ),
      409,
      'Plus de place libre sur cette mission.',
    );
    expectApi(
      const PostgrestException(
        message: 'Envoyez votre pièce d’identité avant de postuler.',
        code: 'MO422',
      ),
      422,
      'Envoyez votre pièce d’identité avant de postuler.',
    );
  });

  test('erreurs d’authentification traduites', () {
    expectApi(
      const AuthException(
        'Invalid login credentials',
        code: 'invalid_credentials',
      ),
      422,
      'E-mail ou mot de passe incorrect.',
    );
    expectApi(
      const AuthException(
        'User already registered',
        code: 'user_already_exists',
      ),
      422,
      'Un compte existe déjà avec cet e-mail.',
    );
    expectApi(
      const AuthException('exists', code: 'email_exists'),
      422,
      'Un compte existe déjà avec cet e-mail.',
    );
    expectApi(
      const AuthException('weak', code: 'weak_password'),
      422,
      'Au moins 6 caractères.',
    );
    expectApi(
      const AuthException('bad', code: 'email_address_invalid'),
      422,
      'Adresse e-mail invalide.',
    );
    expectApi(
      const AuthException('bad', code: 'validation_failed'),
      422,
      'Adresse e-mail invalide.',
    );
  });

  test('pas de réseau : statut 0', () {
    expectApi(TimeoutException('lent'), 0, 'Pas de connexion internet.');
    expectApi(
      const SocketException('hors ligne'),
      0,
      'Pas de connexion internet.',
    );
    expectApi(
      http.ClientException('hors ligne'),
      0,
      'Pas de connexion internet.',
    );
    expectApi(AuthRetryableFetchException(), 0, 'Pas de connexion internet.');
    expectApi(const HttpException('coupé'), 0, 'Pas de connexion internet.');
    expectApi(const TlsException('tls'), 0, 'Pas de connexion internet.');
    expectApi(
      const HandshakeException('poignée'),
      0,
      'Pas de connexion internet.',
    );
  });

  test('fichier local manquant : 422', () {
    expectApi(
      const FileSystemException('absent', '/tmp/x.jpg'),
      422,
      'Photo introuvable, reprenez-la.',
    );
    expectApi(
      const PathNotFoundException('/tmp/x.jpg', OSError('No such file', 2)),
      422,
      'Photo introuvable, reprenez-la.',
    );
  });

  test(
    'les autres erreurs d’entrée-sortie ne passent pas pour un réseau coupé',
    () {
      expect(apiExceptionFrom(const StdinException('stdin')).statusCode, 500);
    },
  );

  test('Storage : photo trop lourde → 422', () {
    const heavy = (422, 'Photo trop lourde. Reprenez-la.');
    for (final error in const [
      StorageException(
        'The object exceeded the maximum allowed size',
        statusCode: '413',
        error: 'Payload too large',
      ),
      StorageException('Payload too large', statusCode: '400'),
      StorageException(
        'The object exceeded the maximum allowed size',
        error: 'EntityTooLarge',
      ),
    ]) {
      final result = apiExceptionFrom(error);
      expect((result.statusCode, result.message), heavy, reason: '$error');
    }
  });

  test('Storage : format refusé → 422', () {
    const format = (422, 'Format de photo non accepté.');
    for (final error in const [
      StorageException(
        'mime type image/gif is not supported',
        statusCode: '415',
        error: 'invalid_mime_type',
      ),
      StorageException(
        'mime type image/heic is not supported',
        statusCode: '400',
        error: 'invalid_mime_type',
      ),
    ]) {
      final result = apiExceptionFrom(error);
      expect((result.statusCode, result.message), format, reason: '$error');
    }
  });

  test('Storage : autre erreur → 500 en français, jamais le texte brut', () {
    for (final error in const [
      StorageException('Internal Server Error', statusCode: '500'),
      StorageException(
        'new row violates row-level security policy',
        statusCode: '403',
        error: 'Unauthorized',
      ),
      StorageException('Bucket not found', statusCode: '404'),
    ]) {
      final result = apiExceptionFrom(error);
      expect(
        (result.statusCode, result.message),
        (500, 'Envoi de la photo impossible. Réessayez.'),
        reason: '$error',
      );
    }
  });

  test('session expirée : 401', () {
    expectApi(
      const PostgrestException(message: 'JWT expired', code: 'PGRST301'),
      401,
      'Votre session a expiré. Reconnectez-vous.',
    );
    expectApi(
      const PostgrestException(message: 'JWT expired', code: 'PGRST303'),
      401,
      'Votre session a expiré. Reconnectez-vous.',
    );
  });

  test('autres erreurs : 500', () {
    expect(
      apiExceptionFrom(
        const PostgrestException(message: 'boom', code: '42P01'),
      ).statusCode,
      500,
    );
    expect(apiExceptionFrom(StateError('x')).statusCode, 500);
  });
}
