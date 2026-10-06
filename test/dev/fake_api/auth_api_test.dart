import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/dev/fake_api/seed.dart';

import '../../helpers/test_clock.dart';

FakeApiClient client({String? session}) => FakeApiClient(
  seedDatabase(fixedNow, sessionUserId: session),
  clock: () => fixedNow,
  latency: Duration.zero,
);

Future<ApiException> error(Future<Object?> call) async {
  try {
    await call;
  } on ApiException catch (e) {
    return e;
  }
  fail('exception attendue');
}

void main() {
  test('connexion d’un compte de démo', () async {
    final api = client();
    final account =
        await api.post(
              '/auth/login',
              body: {'email': 'annonceur@demo.bj', 'password': 'demo123'},
            )
            as Map;
    expect(account['id'], 'u10');
    expect(account['role'], 'poster');
    final me = await api.get('/me') as Map;
    expect(me['firstName'], 'Mireille');
  });

  test('e-mail insensible à la casse et aux espaces', () async {
    final api = client();
    final account =
        await api.post(
              '/auth/login',
              body: {'email': '  Executant@Demo.bj ', 'password': 'demo123'},
            )
            as Map;
    expect(account['id'], 'u1');
  });

  test('mauvais mot de passe', () async {
    final e = await error(
      client().post(
        '/auth/login',
        body: {'email': 'annonceur@demo.bj', 'password': 'nope'},
      ),
    );
    expect(
      (e.statusCode, e.message),
      (422, 'E-mail ou mot de passe incorrect.'),
    );
  });

  test(
    'création de compte : connecté, sans rôle ; doublon et validations refusés',
    () async {
      final api = client();
      final account =
          await api.post(
                '/auth/signup',
                body: {'email': 'awa@demo.bj', 'password': 'secret1'},
              )
              as Map;
      expect(account['role'], isNull);
      expect((await api.get('/me') as Map)['id'], account['id']);
      expect(
        (await error(
          api.post(
            '/auth/signup',
            body: {'email': 'awa@demo.bj', 'password': 'secret1'},
          ),
        )).message,
        'Un compte existe déjà avec cet e-mail.',
      );
      expect(
        (await error(
          api.post(
            '/auth/signup',
            body: {'email': 'pas-un-email', 'password': 'secret1'},
          ),
        )).message,
        'Adresse e-mail invalide.',
      );
      expect(
        (await error(
          api.post(
            '/auth/signup',
            body: {'email': 'b@demo.bj', 'password': '123'},
          ),
        )).message,
        'Au moins 6 caractères.',
      );
    },
  );

  test('choix du rôle annonceur : portefeuille de 200 000 FCFA', () async {
    final api = client();
    await api.post(
      '/auth/signup',
      body: {'email': 'awa@demo.bj', 'password': 'secret1'},
    );
    final me = await api.post('/me/role', body: {'role': 'poster'}) as Map;
    expect(me['role'], 'poster');
    expect(api.db.wallets[me['id']]!['balance'], 200000);
  });

  test('Review focus : route protégée après déconnexion → 401', () async {
    final api = client(session: 'u1');
    await api.post('/auth/logout');
    final e = await error(api.get('/me/applications'));
    expect(
      (e.statusCode, e.message),
      (401, 'Votre session a expiré. Reconnectez-vous.'),
    );
  });

  test('les routes de code SMS n’existent plus', () async {
    final e = await error(
      client().post('/auth/phone', body: {'phone': '+22997123456'}),
    );
    expect(e.statusCode, 404);
  });
}
