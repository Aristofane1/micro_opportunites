import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/dev/fake_api/seed.dart';

import '../../helpers/test_clock.dart';

FakeApiClient newClient() => FakeApiClient(
  seedDatabase(fixedNow),
  clock: () => fixedNow,
  latency: Duration.zero,
);

Map<String, dynamic> asJson(Object? value) => value! as Map<String, dynamic>;

void main() {
  test('5 km autour : 7 missions, la plus récente d’abord', () async {
    final page = asJson(await newClient().get('/missions', query: {'km': '5'}));
    expect(page['total'], 7);
    final first = asJson((page['items'] as List).first);
    expect(first['title'], 'Distribution de flyers au carrefour');
  });

  test('20 km inclut Cotonou mais pas Ouidah', () async {
    final page = asJson(
      await newClient().get('/missions', query: {'km': '20'}),
    );
    expect(page['total'], 11);
  });

  test('recherche plein texte et filtres', () async {
    final client = newClient();
    final windows = asJson(
      await client.get('/missions', query: {'q': 'windows'}),
    );
    expect(windows['total'], 1);
    final none = asJson(
      await client.get('/missions', query: {'q': 'plomberie'}),
    );
    expect(none['total'], 0);
    final byCity = asJson(
      await client.get('/missions', query: {'city': 'Cotonou'}),
    );
    expect(byCity['total'], 4);
  });

  test('une mission publique ne révèle jamais l’adresse', () async {
    final mission = asJson(await newClient().get('/missions/m1'));
    expect(mission.containsKey('private'), isFalse);
    expect(mission.toString(), isNot(contains('Kpota')));
  });

  test('postuler deux fois renvoie 409', () async {
    final client = newClient();
    final created = asJson(
      await client.post(
        '/missions/m1/applications',
        body: {'message': 'Dispo'},
      ),
    );
    expect(created['status'], 'pending');
    await expectLater(
      client.post('/missions/m1/applications', body: {'message': ''}),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 409),
      ),
    );
  });

  test('confirmer l’offre crée une affectation avec l’adresse', () async {
    final client = newClient();
    final app = asJson(await client.post('/applications/a1/confirm'));
    expect(app['status'], 'confirmed');
    final assignment = asJson(
      await client.get('/assignments/${app['assignmentId']}'),
    );
    expect(assignment['status'], 'confirmed');
    expect(assignment['address'], 'Tankpè, rue des Écoles');
  });

  test('check-in, check-out puis gains « à valider »', () async {
    final client = newClient();
    await expectLater(
      client.post(
        '/assignments/as1/check-in',
        body: {'lat': 6.50, 'lng': 2.40},
      ),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 422),
      ),
    );
    final inProgress = asJson(
      await client.post(
        '/assignments/as1/check-in',
        body: {'lat': 6.41386, 'lng': 2.3280},
      ),
    );
    expect(inProgress['status'], 'in_progress');
    expect(inProgress['checkInDistanceM'], 40);
    final submitted = asJson(
      await client.post(
        '/assignments/as1/check-out',
        body: {'note': 'Fait', 'photos': <String>[]},
      ),
    );
    expect(submitted['status'], 'submitted');
    final earnings = asJson(await client.get('/me/earnings'));
    final lines = (earnings['lines'] as List).cast<Map<String, dynamic>>();
    expect(
      lines.firstWhere(
        (l) => l['title'] == 'Accueil des invités à un salon',
      )['status'],
      'awaiting_validation',
    );
    expect(asJson(earnings['paid'])['amount'], 32000);
  });

  test('nextError simule une panne réseau une seule fois', () async {
    final client = newClient()..nextError = const ApiException(0, 'hors-ligne');
    await expectLater(client.get('/me'), throwsA(isA<ApiException>()));
    expect(asJson(await client.get('/me'))['firstName'], 'Rodrigue');
  });

  test('postuler à une mission complète : 409', () async {
    final client = newClient();
    client.db.missions['m1']!['slotsFree'] = 0;
    await expectLater(
      client.post('/missions/m1/applications', body: {'message': ''}),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 409)
            .having((e) => e.message, 'message', 'Cette mission est complète.'),
      ),
    );
  });
}
