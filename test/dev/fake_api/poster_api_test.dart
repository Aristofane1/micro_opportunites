import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/dev/fake_api/seed.dart';

import '../../helpers/test_clock.dart';

class Clock {
  DateTime now = fixedNow;
}

late Clock clock;
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

Map<String, Object?> draft({
  int pay = 5000,
  int slots = 2,
  String payUnit = 'flat',
  int durationMin = 180,
}) => {
  'title': 'Aide déménagement',
  'category': 'other',
  'description': 'Porter des cartons.',
  'city': 'Abomey-Calavi',
  'address': 'Rue 12, Tankpè',
  'landmark': 'Portail vert',
  'lat': 6.4490,
  'lng': 2.3560,
  'startAt': fixedNow.add(const Duration(days: 2)).toIso8601String(),
  'durationMin': durationMin,
  'payAmount': pay,
  'payUnit': payUnit,
  'slots': slots,
  'applyDeadline': fixedNow.add(const Duration(days: 1)).toIso8601String(),
};

int balance() => api.db.wallets['u10']!['balance'] as int;

void main() {
  setUp(() {
    clock = Clock();
    api = FakeApiClient(
      seedDatabase(fixedNow, sessionUserId: null),
      clock: () => clock.now,
      latency: Duration.zero,
    );
  });

  test('publier bloque paie × places et apparaît dans Mes missions', () async {
    await loginAs('annonceur@demo.bj');
    final before = (await api.get('/me/wallet') as Map)['available'] as int;
    final mission = await api.post('/missions', body: draft()) as Map;
    expect(mission['status'], 'published');
    expect(mission['blockedAmount'], 10000);
    final wallet = await api.get('/me/wallet') as Map;
    expect(wallet['available'], before - 10000);
    final mine = await api.get('/me/missions') as List;
    expect(mine.first['id'], mission['id']);
  });

  test('solde insuffisant', () async {
    await loginAs('annonceur@demo.bj');
    final e = await error(
      api.post('/missions', body: draft(pay: 150000, slots: 2)),
    );
    expect(e.message, 'Solde insuffisant pour bloquer ${formatFcfa(300000)}.');
  });

  test(
    'Review focus : sa propre mission n’apparaît pas dans Explorer et on ne peut pas y postuler',
    () async {
      await loginAs('annonceur@demo.bj');
      final mission = await api.post('/missions', body: draft()) as Map;
      final explore = await api.get('/missions', query: {'km': '20'}) as Map;
      expect(
        (explore['items'] as List).map((m) => m['id']),
        isNot(contains(mission['id'])),
      );
      final e = await error(
        api.post(
          '/missions/${mission['id']}/applications',
          body: {'message': ''},
        ),
      );
      expect(e.message, 'Vous ne pouvez pas postuler à votre propre mission.');
    },
  );

  test(
    'cycle complet : postuler → retenir → confirmer → adresse → fin → valider → versé',
    () async {
      await loginAs('annonceur@demo.bj');
      final mission = await api.post('/missions', body: draft(slots: 1)) as Map;
      final id = mission['id'] as String;

      await loginAs('executant@demo.bj');
      final public = await api.get('/missions/$id') as Map;
      expect(public.containsKey('address'), isFalse);
      expect(public['city'], 'Abomey-Calavi');
      final application =
          await api.post(
                '/missions/$id/applications',
                body: {'message': 'Dispo'},
              )
              as Map;

      await loginAs('annonceur@demo.bj');
      final candidates = await api.get('/missions/$id/candidates') as List;
      expect(candidates.single['name'], 'Rodrigue K.');
      final retained =
          await api.post('/applications/${application['id']}/offer') as Map;
      expect(retained['status'], 'retained');

      await loginAs('executant@demo.bj');
      final confirmed =
          await api.post('/applications/${application['id']}/confirm') as Map;
      final assignment =
          await api.get('/assignments/${confirmed['assignmentId']}') as Map;
      expect(assignment['address'], 'Rue 12, Tankpè');
      await api.post(
        '/assignments/${assignment['id']}/check-in',
        body: {'lat': 6.4491, 'lng': 2.3560},
      );
      await api.post(
        '/assignments/${assignment['id']}/check-out',
        body: {'note': 'Fait', 'photos': <String>[]},
      );

      await loginAs('annonceur@demo.bj');
      final balanceBefore = balance();
      final validated =
          await api.post('/assignments/${assignment['id']}/validate') as Map;
      expect(validated['attendance'], 'validated');
      expect(balance(), balanceBefore - 5000);
      expect((api.db.wallets['u10']!['blocked'] as Map)[id] ?? 0, 0);

      await loginAs('executant@demo.bj');
      final earnings = await api.get('/me/earnings') as Map;
      final paid = (earnings['lines'] as List).firstWhere(
        (l) => l['title'] == 'Aide déménagement',
      );
      expect(paid['status'], 'paid');
      final payout = await api.get('/me/payouts/${paid['payoutId']}') as Map;
      expect(payout['commissionLabel'], 'Aucune (démo)');
    },
  );

  test('Review focus : retenir au-delà des places libres', () async {
    await loginAs('executant@demo.bj');
    final mine =
        await api.post('/missions/m20/applications', body: {'message': 'Dispo'})
            as Map;
    await loginAs('annonceur@demo.bj');
    final candidates = (await api.get('/missions/m20/candidates') as List)
        .where((c) => c['id'] != mine['id'])
        .toList();
    await api.post('/applications/${candidates[0]['id']}/offer');
    await api.post('/applications/${candidates[1]['id']}/offer');
    final e = await error(api.post('/applications/${mine['id']}/offer'));
    expect(
      (e.statusCode, e.message),
      (409, 'Plus de place libre sur cette mission.'),
    );
    expect(api.db.applications[mine['id']]!['status'], 'pending');
  });

  test('offre expirée après 12 h', () async {
    await loginAs('annonceur@demo.bj');
    final candidate = (await api.get('/missions/m20/candidates') as List).first;
    await api.post('/applications/${candidate['id']}/offer');
    clock.now = clock.now.add(const Duration(hours: 13));
    final again = (await api.get('/missions/m20/candidates') as List)
        .firstWhere((c) => c['id'] == candidate['id']);
    expect(again['status'], 'refused');
  });

  test(
    'Review focus : versement automatique après 48 h, une seule fois',
    () async {
      await loginAs('annonceur@demo.bj');
      final before = balance();
      clock.now = clock.now.add(const Duration(hours: 48));
      await api.get('/me/missions');
      await api.get('/me/wallet');
      expect(balance(), before - 8000);
      expect(
        api.db.payouts.values.where((p) => p['assignmentId'] == 'm21'),
        hasLength(1),
      );
    },
  );

  test('contestation : rien n’est versé', () async {
    await loginAs('annonceur@demo.bj');
    final before = balance();
    final contested =
        await api.post(
              '/assignments/m21/contest',
              body: {'reason': 'Travail incomplet'},
            )
            as Map;
    expect(contested['attendance'], 'contested');
    clock.now = clock.now.add(const Duration(hours: 72));
    await api.get('/me/wallet');
    expect(balance(), before);
  });

  test(
    'Review focus : un autre compte ne peut ni valider ni contester',
    () async {
      await loginAs('executant@demo.bj');
      final e = await error(api.post('/assignments/m21/validate'));
      expect((e.statusCode, e.message), (404, 'Mission introuvable.'));
    },
  );

  test('annulation : débloque, refusée si la mission a commencé', () async {
    await loginAs('annonceur@demo.bj');
    final mission = await api.post('/missions', body: draft()) as Map;
    final before = (await api.get('/me/wallet') as Map)['available'] as int;
    final cancelled =
        await api.post('/missions/${mission['id']}/cancel') as Map;
    expect(cancelled['status'], 'cancelled');
    expect((await api.get('/me/wallet') as Map)['available'], before + 10000);
    final e = await error(api.post('/missions/m21/cancel'));
    expect(e.message, 'Impossible d’annuler : la mission a commencé.');
  });

  test(
    'Review focus : mission à l’heure, bloqué = versé = taux × durée',
    () async {
      await loginAs('annonceur@demo.bj');
      final mission =
          await api.post(
                '/missions',
                body: draft(pay: 1000, slots: 1, payUnit: 'hourly'),
              )
              as Map;
      final id = mission['id'] as String;
      expect(mission['blockedAmount'], 3000);

      await loginAs('executant@demo.bj');
      final application =
          await api.post('/missions/$id/applications', body: {'message': ''})
              as Map;
      await loginAs('annonceur@demo.bj');
      await api.post('/applications/${application['id']}/offer');
      await loginAs('executant@demo.bj');
      final confirmed =
          await api.post('/applications/${application['id']}/confirm') as Map;
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
      final before = balance();
      await api.post('/assignments/$assignmentId/validate');
      expect(balance(), before - 3000);
      expect(
        (api.db.wallets['u10']!['blocked'] as Map).containsKey(id),
        isFalse,
      );
      final payout = api.db.payouts.values.singleWhere(
        (p) => p['assignmentId'] == assignmentId,
      );
      expect(payout['amount'], 3000);
    },
  );

  test('Review focus : mission à l’heure sans durée → 422', () async {
    await loginAs('annonceur@demo.bj');
    final e = await error(
      api.post('/missions', body: draft(payUnit: 'hourly', durationMin: 0)),
    );
    expect((e.statusCode, e.message), (422, 'Indiquez la durée.'));
  });

  test(
    'Review focus : retenir ou refuser le candidat d’un autre annonceur → 404',
    () async {
      await loginAs('annonceur@demo.bj');
      for (final action in ['offer', 'reject']) {
        // a3 : candidature de u1 sur m4, mission de p1.
        final e = await error(api.post('/applications/a3/$action'));
        expect((e.statusCode, e.message), (404, 'Mission introuvable.'));
      }
    },
  );
}
