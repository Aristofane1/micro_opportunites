import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import '../../support/fake_backend/fake_api_client.dart';
import '../../support/fake_backend/seed.dart';

import '../../helpers/test_clock.dart';

/// Règles du faux serveur alignées sur la migration 000007 : date limite de
/// candidature, mission commencée, clôture du recrutement, position de
/// l'appareil, selfie manquant.
late DateTime now;
late FakeApiClient api;

Future<void> loginAs(String email) =>
    api.post('/auth/login', body: {'email': email, 'password': 'demo123'});

Future<ApiException> error(Future<Object?> call) async {
  try {
    await call;
  } on ApiException catch (e) {
    return e;
  }
  fail('exception attendue');
}

Map<String, Object?> draft({int slots = 2}) => {
  'title': 'Aide déménagement',
  'category': 'other',
  'description': 'Porter des cartons.',
  'city': 'Abomey-Calavi',
  'address': 'Rue 12, Tankpè',
  'landmark': 'Portail vert',
  'lat': 6.4490,
  'lng': 2.3560,
  'startAt': fixedNow.add(const Duration(days: 2)).toIso8601String(),
  'durationMin': 180,
  'payAmount': 5000,
  'payUnit': 'flat',
  'slots': slots,
  'applyDeadline': fixedNow.add(const Duration(days: 1)).toIso8601String(),
};

/// [email] postule à [missionId] ; l'annonceur le retient ; il confirme.
Future<Map> confirmedOn(String missionId, String email) async {
  await loginAs(email);
  final application =
      await api.post('/missions/$missionId/applications', body: {'message': ''})
          as Map;
  await loginAs('annonceur@demo.bj');
  await api.post('/applications/${application['id']}/offer');
  await loginAs(email);
  return await api.post('/applications/${application['id']}/confirm') as Map;
}

Map<String, int> blocked() =>
    api.db.wallets['u10']!['blocked'] as Map<String, int>;

int balance() => api.db.wallets['u10']!['balance'] as int;

int available() => balance() - blocked().values.fold(0, (a, b) => a + b);

String past() =>
    now.subtract(const Duration(minutes: 1)).toUtc().toIso8601String();

void main() {
  setUp(() {
    now = fixedNow;
    api = FakeApiClient(
      seedDatabase(fixedNow, sessionUserId: null),
      clock: () => now,
      latency: Duration.zero,
    );
  });

  group('date limite de candidature', () {
    test('Explorer et la carte masquent les candidatures closes', () async {
      api.db.missions['m1']!['applyDeadline'] = past();
      await loginAs('executant@demo.bj');
      final ids = [
        for (final m
            in ((await api.get('/missions', query: {'km': '20'})
                    as Map)['items']
                as List))
          m['id'],
      ];
      expect(ids, isNot(contains('m1')));
      expect(ids, contains('m6'));
      final cities =
          (await api.get('/missions/cities') as Map)['items'] as List;
      final calavi = cities.firstWhere((c) => c['city'] == 'Abomey-Calavi');
      api.db.missions['m1']!['applyDeadline'] = now
          .add(const Duration(days: 1))
          .toIso8601String();
      final citiesAfter =
          (await api.get('/missions/cities') as Map)['items'] as List;
      final calaviAfter = citiesAfter.firstWhere(
        (c) => c['city'] == 'Abomey-Calavi',
      );
      expect(calaviAfter['count'], (calavi['count'] as int) + 1);
    });

    test('postuler après la date limite → 409', () async {
      api.db.missions['m1']!['applyDeadline'] = past();
      await loginAs('executant@demo.bj');
      final e = await error(
        api.post('/missions/m1/applications', body: {'message': ''}),
      );
      expect(
        (e.statusCode, e.message),
        (409, 'Les candidatures sont closes pour cette mission.'),
      );
    });
  });

  group('mission commencée', () {
    test('plus d’offre possible', () async {
      api.db.missions['m20']!['startAt'] = past();
      await loginAs('annonceur@demo.bj');
      final e = await error(api.post('/applications/a20/offer'));
      expect((e.statusCode, e.message), (409, 'La mission a déjà commencé.'));
    });

    test('plus de confirmation possible', () async {
      api.db.missions['m2']!['startAt'] = past();
      await loginAs('executant@demo.bj');
      final e = await error(api.post('/applications/a1/confirm'));
      expect((e.statusCode, e.message), (409, 'La mission a déjà commencé.'));
    });
  });

  group('clôture du recrutement au début de la mission', () {
    test('places vides débloquées, candidatures closes, idempotent', () async {
      await confirmedOn('m20', 'executant@demo.bj');
      expect(blocked()['m20'], 12000);
      final balanceBefore = balance();
      final availableBefore = available();
      now = now.add(const Duration(days: 4));
      await loginAs('annonceur@demo.bj');
      await api.get('/me/wallet');
      final m20 = api.db.missions['m20']!;
      expect((m20['status'], m20['slotsFree']), ('filled', 0));
      expect(api.db.applications['a20']!['status'], 'rejected');
      expect(api.db.applications['a21']!['status'], 'rejected');
      expect(blocked()['m20'], 6000);
      // m21 est versée au passage (8 000) : solde et montant bloqué baissent
      // d'autant, le disponible ne gagne que la place vide de m20.
      expect(balance(), balanceBefore - 8000);
      expect(available(), availableBefore + 6000);
      await api.get('/me/wallet');
      expect(blocked()['m20'], 6000);
      expect(balance(), balanceBefore - 8000);
      expect(available(), availableBefore + 6000);
    });

    test('offre en cours expirée au début de la mission', () async {
      await loginAs('annonceur@demo.bj');
      await api.post('/applications/a20/offer');
      api.db.missions['m20']!['startAt'] = past();
      await api.get('/me/wallet');
      expect(api.db.applications['a20']!['status'], 'expired');
      expect(api.db.applications['a21']!['status'], 'rejected');
    });

    test('sans affectation : mission annulée, tout est débloqué', () async {
      await loginAs('annonceur@demo.bj');
      final before = available();
      final mission = await api.post('/missions', body: draft()) as Map;
      expect(available(), before - 10000);
      now = now.add(const Duration(days: 2, hours: 1));
      final mine = await api.get('/me/missions/${mission['id']}') as Map;
      expect(mine['status'], 'cancelled');
      expect(blocked().containsKey(mission['id']), isFalse);
      expect(available(), before);
    });

    test(
      'désistement après la clôture : place débloquée, puis annulée',
      () async {
        await loginAs('annonceur@demo.bj');
        final mission = await api.post('/missions', body: draft()) as Map;
        final id = mission['id'] as String;
        final confirmed = await confirmedOn(id, 'executant@demo.bj');
        final before = available();
        now = now.add(const Duration(days: 2, hours: 1));
        await loginAs('annonceur@demo.bj');
        expect(blocked()[id], 5000);
        expect(available(), before + 5000);
        await loginAs('executant@demo.bj');
        await api.post('/assignments/${confirmed['assignmentId']}/withdraw');
        await loginAs('annonceur@demo.bj');
        final mine = await api.get('/me/missions/$id') as Map;
        expect(mine['status'], 'cancelled');
        expect(blocked().containsKey(id), isFalse);
        expect(available(), before + 10000);
      },
    );

    test(
      'affectations contestée et en cours : seules les places libres débloquées',
      () async {
        await loginAs('annonceur@demo.bj');
        final mission =
            await api.post('/missions', body: draft(slots: 4)) as Map;
        final id = mission['id'] as String;
        final contested = await confirmedOn(id, 'executant@demo.bj');
        final working = await confirmedOn(id, 'executant2@demo.bj');
        await api.post(
          '/assignments/${working['assignmentId']}/check-in',
          body: {'lat': 6.4491, 'lng': 2.3560},
        );
        await loginAs('executant@demo.bj');
        await api.post(
          '/assignments/${contested['assignmentId']}/check-in',
          body: {'lat': 6.4491, 'lng': 2.3560},
        );
        await api.post(
          '/assignments/${contested['assignmentId']}/check-out',
          body: {'note': 'Fait', 'photos': <String>[]},
        );
        await loginAs('annonceur@demo.bj');
        await api.post(
          '/assignments/${contested['assignmentId']}/contest',
          body: {'reason': 'Travail incomplet'},
        );
        expect(blocked()[id], 20000);
        final balanceBefore = balance();
        final availableBefore = available();
        now = now.add(const Duration(days: 2, hours: 1));
        await api.get('/me/wallet');
        final statuses = [
          api.db.assignments[contested['assignmentId']]!['status'],
          api.db.assignments[working['assignmentId']]!['status'],
        ];
        expect(statuses, ['contested', 'in_progress']);
        final m = api.db.missions[id]!;
        expect((m['status'], m['slotsFree']), ('filled', 0));
        expect(blocked()[id], 10000);
        // m21 est versée au passage : le disponible ne gagne que les 2 places.
        expect(balance(), balanceBefore - 8000);
        expect(available(), availableBefore + 10000);
        await api.get('/me/wallet');
        expect(blocked()[id], 10000);
      },
    );

    test(
      'terminée : affectations terminales et une payée, sans être complète',
      () async {
        await loginAs('annonceur@demo.bj');
        final mission = await api.post('/missions', body: draft()) as Map;
        final id = mission['id'] as String;
        final confirmed = await confirmedOn(id, 'executant@demo.bj');
        final assignmentId = confirmed['assignmentId'];
        await api.post(
          '/assignments/$assignmentId/check-in',
          body: {'lat': 6.4491, 'lng': 2.3560},
        );
        await api.post(
          '/assignments/$assignmentId/check-out',
          body: {'note': 'Fait', 'photos': <String>[]},
        );
        await loginAs('annonceur@demo.bj');
        await api.post('/assignments/$assignmentId/validate');
        // Payée avant le début : le recrutement n'est pas clos.
        final early = await api.get('/me/missions/$id') as Map;
        expect(early['status'], isNot('completed'));
        final balanceBefore = balance();
        now = now.add(const Duration(days: 2, hours: 1));
        final mine = await api.get('/me/missions/$id') as Map;
        expect(mine['status'], 'completed');
        expect(blocked().containsKey(id), isFalse);
        expect(balance(), balanceBefore - 8000); // m21 versée au passage
      },
    );
  });

  test('Explorer : rayon autour de la position de l’appareil', () async {
    await loginAs('executant@demo.bj');
    Future<List> ids(Map<String, String> query) async => [
      for (final m
          in ((await api.get('/missions', query: query) as Map)['items']
              as List))
        m['id'],
    ];
    expect(await ids({'km': '5'}), isNot(contains('m10')));
    expect(
      await ids({'km': '5', 'lat': '6.3667', 'lng': '2.085'}),
      contains('m10'),
    );
    expect(
      await ids({'km': '5', 'lat': '6.3667'}),
      isNot(contains('m10')),
      reason: 'position incomplète : profil',
    );
  });

  test('pièce d’identité : selfie manquant', () async {
    await api.post(
      '/auth/signup',
      body: {'email': 'selfie@demo.bj', 'password': 'secret1'},
    );
    final e = await error(
      api.post(
        '/auth/kyc',
        body: {
          'documentType': 'id_card',
          'countryCode': 'BJ',
          'frontPath': '/tmp/front.jpg',
          'backPath': '/tmp/back.jpg',
        },
      ),
    );
    expect(
      (e.statusCode, e.message),
      (422, 'Prenez un selfie pour vérifier votre identité.'),
    );
  });
}
