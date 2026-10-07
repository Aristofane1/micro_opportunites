import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import '../../support/fake_backend/fake_api_client.dart';
import '../../support/fake_backend/fake_database.dart';
import '../../support/fake_backend/fake_routing.dart';
import '../../support/fake_backend/handlers/applications_handlers.dart';
import '../../support/fake_backend/handlers/poster_handlers.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

/// Appelle un handler du faux serveur au nom de [userId].
Json _as(
  FakeDatabase db,
  String userId,
  FakeHandler handler, {
  String? id,
  Json body = const {},
}) {
  db.sessionUserId = userId;
  return handler(
        db,
        FakeRequest(
          params: {'id': ?id},
          query: const {},
          body: body,
          now: fixedNow,
        ),
      )
      as Json;
}

void main() {
  testWidgets('u1 confirmé sur une mission de u10, u10 annule : u1 le voit', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      initialLocation: WorkerPaths.applications,
      beforePump: (container) {
        final db = (container.read(apiClientProvider) as FakeApiClient).db;
        final mission = _as(
          db,
          'u10',
          publishMission,
          body: {
            'title': 'Aide déménagement',
            'category': 'other',
            'description': 'Porter des cartons.',
            'city': 'Abomey-Calavi',
            'address': 'Rue 12, Tankpè',
            'landmark': 'Portail vert',
            'lat': 6.449,
            'lng': 2.356,
            'startAt': fixedNow.add(const Duration(days: 2)).toIso8601String(),
            'durationMin': 180,
            'payAmount': 5000,
            'payUnit': 'flat',
            'slots': 1,
            'applyDeadline': fixedNow
                .add(const Duration(days: 1))
                .toIso8601String(),
          },
        );
        final missionId = mission['id'] as String;
        final application = _as(
          db,
          'u1',
          applyToMission,
          id: missionId,
          body: {'message': ''},
        );
        _as(db, 'u10', offerApplication, id: application['id'] as String);
        _as(db, 'u1', confirmOffer, id: application['id'] as String);
        _as(db, 'u10', cancelMission, id: missionId);
        db.sessionUserId = 'u1';
      },
    );

    await tester.tap(find.text('Passées'));
    await tester.pumpAndSettle();
    expect(find.text('Annulée par l’annonceur'), findsOneWidget);

    await tester.tap(find.text('Aide déménagement'));
    await tester.pumpAndSettle();
    expect(find.text('Mission annulée par l’annonceur'), findsOneWidget);
    expect(find.text('Vous vous êtes désisté de cette mission'), findsNothing);
  });
}
