import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:micro_opportunites/app/backend/supabase_api_client.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _uid = '11111111-2222-4333-8444-555555555555';

String _jwt() {
  String part(Map<String, Object?> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  final exp =
      DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch ~/
      1000;
  return '${part({'alg': 'HS256', 'typ': 'JWT'})}.'
      '${part({'sub': _uid, 'exp': exp, 'role': 'authenticated'})}.signature';
}

Map<String, Object?> _session() => {
  'access_token': _jwt(),
  'token_type': 'bearer',
  'expires_in': 3600,
  'refresh_token': 'refresh',
  'user': {
    'id': _uid,
    'aud': 'authenticated',
    'email': 'executant@demo.bj',
    'app_metadata': <String, Object?>{},
    'user_metadata': <String, Object?>{},
    'created_at': '2026-10-01T00:00:00Z',
  },
};

const _me = {
  'id': _uid,
  'email': 'executant@demo.bj',
  'firstName': 'Rodrigue',
  'city': 'Abomey-Calavi',
  'role': 'worker',
};

/// Faux projet Supabase : enregistre chaque requête, répond selon le chemin.
class _Server {
  final requests = <http.Request>[];
  Map<String, http.Response Function(http.Request)> rpc = {};

  /// Réponse imposée aux dépôts Storage (sinon succès).
  http.Response Function(http.Request)? storage;

  late final client = SupabaseClient(
    'https://demo.supabase.co',
    'anon',
    authOptions: const AuthClientOptions(
      autoRefreshToken: false,
      authFlowType: AuthFlowType.implicit,
    ),
    httpClient: MockClient((request) async {
      requests.add(request);
      final path = request.url.path;
      if (path == '/auth/v1/token') {
        return _json(request, _session());
      }
      if (path == '/auth/v1/signup') {
        return _json(request, _session());
      }
      if (path.startsWith('/storage/v1/object/')) {
        final forced = storage;
        if (forced != null) return forced(request);
        return _json(request, {
          'Key': path.substring('/storage/v1/object/'.length),
        });
      }
      if (path.startsWith('/rest/v1/rpc/')) {
        final name = path.substring('/rest/v1/rpc/'.length);
        final handler = rpc[name];
        if (handler != null) return handler(request);
        return _json(request, name == 'me' ? _me : {'ok': name});
      }
      return http.Response('not found', 404, request: request);
    }),
  );

  List<String> get paths => [
    for (final r in requests) '${r.method} ${r.url.path}',
  ];

  Map<String, Object?> rpcBody(String name) =>
      jsonDecode(
            requests.lastWhere((r) => r.url.path == '/rest/v1/rpc/$name').body,
          )
          as Map<String, Object?>;
}

http.Response _json(http.Request request, Object? body, [int status = 200]) =>
    http.Response(
      jsonEncode(body),
      status,
      request: request,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

String _tempPhoto(String name) {
  final dir = Directory.systemTemp.createTempSync('kyc_test');
  addTearDown(() => dir.deleteSync(recursive: true));
  return (File('${dir.path}/$name')..writeAsBytesSync([0xff, 0xd8, 0xff])).path;
}

Future<SupabaseApiClient> _signedIn(_Server server) async {
  final api = SupabaseApiClient(server.client);
  await api.post(
    '/auth/login',
    body: {'email': 'executant@demo.bj', 'password': 'demo123'},
  );
  server.requests.clear();
  return api;
}

List<String> _uploads(_Server server) => [
  for (final p in server.paths)
    if (p.startsWith('POST /storage/v1/object/'))
      p.substring('POST /storage/v1/object/'.length),
];

void main() {
  test('connexion : Supabase Auth puis RPC me, en POST', () async {
    final server = _Server();
    final api = SupabaseApiClient(server.client);
    final account = await api.post(
      '/auth/login',
      body: {'email': ' executant@demo.bj ', 'password': 'demo123'},
    );
    expect(account, _me);
    expect(server.paths, ['POST /auth/v1/token', 'POST /rest/v1/rpc/me']);
  });

  test('inscription : validations locales avant tout appel', () async {
    final server = _Server();
    final api = SupabaseApiClient(server.client);
    await expectLater(
      api.post(
        '/auth/signup',
        body: {'email': 'pas-un-email', 'password': 'secret1'},
      ),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'Adresse e-mail invalide.',
        ),
      ),
    );
    await expectLater(
      api.post(
        '/auth/signup',
        body: {'email': 'awa@demo.bj', 'password': '123'},
      ),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'Au moins 6 caractères.',
        ),
      ),
    );
    expect(server.requests, isEmpty);
    await api.post(
      '/auth/signup',
      body: {'email': 'Awa@demo.bj', 'password': 'secret1'},
    );
    expect(server.paths, ['POST /auth/v1/signup', 'POST /rest/v1/rpc/me']);
    expect(jsonDecode(server.requests.first.body)['email'], 'awa@demo.bj');
  });

  test('lecture : RPC appelée en POST avec les filtres convertis', () async {
    final server = _Server();
    final api = await _signedIn(server);
    await api.get('/missions', query: {'km': '5'});
    expect(server.paths, ['POST /rest/v1/rpc/list_missions']);
    expect(server.rpcBody('list_missions')['km'], 5);
  });

  test('erreur SQL MO4xx → ApiException avec le message français', () async {
    final server = _Server()
      ..rpc['apply_to_mission'] = (request) => _json(request, {
        'code': 'MO422',
        'message': 'Envoyez votre pièce d’identité avant de postuler.',
        'details': null,
        'hint': null,
      }, 400);
    final api = await _signedIn(server);
    await expectLater(
      api.post('/missions/m1/applications', body: {'message': 'Dispo'}),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 422)
            .having(
              (e) => e.message,
              'message',
              'Envoyez votre pièce d’identité avant de postuler.',
            ),
      ),
    );
  });

  test('route inconnue : 404', () async {
    final api = SupabaseApiClient(_Server().client);
    await expectLater(
      api.get('/inconnu'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
      ),
    );
  });

  test(
    'KYC : photos déposées dans kyc/<uid>/<uuid>/, chemins transmis à submit_kyc',
    () async {
      final server = _Server();
      final api = SupabaseApiClient(server.client);
      await api.post(
        '/auth/login',
        body: {'email': 'executant@demo.bj', 'password': 'demo123'},
      );
      await api.post(
        '/auth/kyc',
        body: {
          'documentType': 'id_card',
          'countryCode': 'BJ',
          'frontPath': _tempPhoto('a.jpg'),
          'backPath': _tempPhoto('b.jpg'),
          'selfiePath': _tempPhoto('c.jpg'),
        },
      );
      final uploads = [
        for (final p in server.paths)
          if (p.startsWith('POST /storage/v1/object/'))
            p.substring('POST /storage/v1/object/'.length),
      ];
      final pattern = RegExp(
        '^kyc/$_uid/[0-9a-f-]{36}/(front|back|selfie)\\.jpg\$',
      );
      expect(uploads, hasLength(3));
      for (final upload in uploads) {
        expect(upload, matches(pattern));
      }
      final args = server.rpcBody('submit_kyc');
      expect(args['document_type'], 'id_card');
      expect(args['country_code'], 'BJ');
      expect(args['front_path'], startsWith('$_uid/'));
      expect(args['front_path'], endsWith('/front.jpg'));
      expect(args['back_path'], endsWith('/back.jpg'));
      expect(args['selfie_path'], endsWith('/selfie.jpg'));
      expect(server.paths.last, 'POST /rest/v1/rpc/submit_kyc');
    },
  );

  test('KYC passeport : pas de verso déposé', () async {
    final server = _Server();
    final api = SupabaseApiClient(server.client);
    await api.post(
      '/auth/login',
      body: {'email': 'executant@demo.bj', 'password': 'demo123'},
    );
    await api.post(
      '/auth/kyc',
      body: {
        'documentType': 'passport',
        'countryCode': 'BJ',
        'frontPath': _tempPhoto('a.jpg'),
        'backPath': null,
        'selfiePath': _tempPhoto('c.jpg'),
      },
    );
    expect(server.paths.where((p) => p.contains('/storage/')), hasLength(2));
    expect(server.rpcBody('submit_kyc')['back_path'], isNull);
  });

  test('check-out : photos déposées dans proofs/<id>/<uuid>/proof_<n>.jpg, '
      'un nouveau dossier à chaque envoi', () async {
    final server = _Server();
    final api = await _signedIn(server);
    final photos = [_tempPhoto('x.jpg'), _tempPhoto('y.jpg')];
    await api.post(
      '/assignments/as1/check-out',
      body: {'note': 'Fait', 'photos': photos},
    );
    final first = _uploads(server);
    final pattern = RegExp(r'^proofs/as1/[0-9a-f-]{36}/proof_[12]\.jpg$');
    expect(first, hasLength(2));
    for (final upload in first) {
      expect(upload, matches(pattern));
    }
    expect(first[0], endsWith('/proof_1.jpg'));
    expect(first[1], endsWith('/proof_2.jpg'));
    // Le premier dossier est l'affectation (clé de la policy Storage).
    expect(first[0].split('/')[1], 'as1');
    expect(server.rpcBody('check_out'), {
      'id': 'as1',
      'note': 'Fait',
      'photos': [for (final u in first) u.substring('proofs/'.length)],
    });

    server.requests.clear();
    await api.post(
      '/assignments/as1/check-out',
      body: {'note': 'Fait', 'photos': photos},
    );
    final second = _uploads(server);
    expect(second.first.split('/')[2], isNot(first.first.split('/')[2]));
  });

  test('dépôt de preuve refusé (403) : check-in d’abord', () async {
    final server = _Server()
      ..storage = (request) => _json(request, {
        'statusCode': '403',
        'error': 'Unauthorized',
        'message': 'new row violates row-level security policy',
      }, 400);
    final api = await _signedIn(server);
    await expectLater(
      api.post(
        '/assignments/as1/check-out',
        body: {
          'note': 'Fait',
          'photos': [_tempPhoto('x.jpg')],
        },
      ),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 409)
            .having(
              (e) => e.message,
              'message',
              'Faites d’abord votre check-in.',
            ),
      ),
    );
    expect(server.paths, isNot(contains('POST /rest/v1/rpc/check_out')));
  });

  test(
    'KYC : un nouvel essai réutilise le même dossier, déjà déposé = gardé',
    () async {
      var failSubmit = true;
      final server = _Server()
        ..rpc['submit_kyc'] = (request) => failSubmit
            ? _json(request, {'code': 'XX000', 'message': 'boom'}, 500)
            : _json(request, {'status': 'pending', 'submittedAt': null});
      final api = await _signedIn(server);
      final body = {
        'documentType': 'id_card',
        'countryCode': 'BJ',
        'frontPath': _tempPhoto('a.jpg'),
        'backPath': _tempPhoto('b.jpg'),
        'selfiePath': _tempPhoto('c.jpg'),
      };
      await expectLater(
        api.post('/auth/kyc', body: body),
        throwsA(isA<ApiException>()),
      );
      final first = _uploads(server);
      final firstArgs = server.rpcBody('submit_kyc');

      // Les fichiers existent déjà : Storage répond « Duplicate ».
      server
        ..requests.clear()
        ..storage = (request) => _json(request, {
          'statusCode': '409',
          'error': 'Duplicate',
          'message': 'The resource already exists',
        }, 400);
      failSubmit = false;
      await api.post('/auth/kyc', body: body);
      expect(_uploads(server), first);
      expect(server.rpcBody('submit_kyc'), firstArgs);

      // Une photo reprise : nouveau dossier, aucune ancienne photo réutilisée.
      server
        ..requests.clear()
        ..storage = null;
      await api.post(
        '/auth/kyc',
        body: {...body, 'frontPath': _tempPhoto('d.jpg')},
      );
      final third = _uploads(server);
      expect(third.first.split('/')[2], isNot(first.first.split('/')[2]));
    },
  );

  test('photo locale introuvable : 422, reprenez-la', () async {
    final server = _Server();
    final api = await _signedIn(server);
    await expectLater(
      api.post(
        '/assignments/as1/check-out',
        body: {
          'note': 'Fait',
          'photos': [
            '${Directory.systemTemp.path}/absente_${DateTime.now().microsecondsSinceEpoch}.jpg',
          ],
        },
      ),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 422)
            .having(
              (e) => e.message,
              'message',
              'Photo introuvable, reprenez-la.',
            ),
      ),
    );
  });

  test('sans session : 401 sans appel réseau', () async {
    final server = _Server();
    final api = SupabaseApiClient(server.client);
    await expectLater(
      api.get('/me'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
    expect(server.requests, isEmpty);
  });

  test('déconnexion : session locale effacée', () async {
    final server = _Server();
    final api = SupabaseApiClient(server.client);
    await api.post(
      '/auth/login',
      body: {'email': 'executant@demo.bj', 'password': 'demo123'},
    );
    expect(server.client.auth.currentSession, isNotNull);
    await api.post('/auth/logout');
    expect(server.client.auth.currentSession, isNull);
  });
}
