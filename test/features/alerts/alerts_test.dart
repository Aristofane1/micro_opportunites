import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';
import 'package:micro_opportunites/features/alerts/presentation/controllers/alerts_controller.dart';

import '../../helpers/pump_worker_app.dart';

Finder _alertTiles() => find.byWidgetPredicate(
  (widget) =>
      widget.key is ValueKey<String> &&
      (widget.key! as ValueKey<String>).value.startsWith('alert.'),
);

void main() {
  test('lister, créer, supprimer', () async {
    final container = createTestContainer();
    final alerts = await container.read(myAlertsProvider.future);
    expect(alerts, hasLength(3));
    expect(alerts.last.title, '« plomberie »');
    expect(alerts.first.subtitle, 'Abomey-Calavi · 10 km · dès 5 000 FCFA');
    final actions = container.read(alertActionsProvider.notifier);
    final created = await actions.create(
      const AlertDraft(
        category: 'Nettoyage',
        zone: 'Cotonou',
        days: 'En semaine',
      ),
    );
    expect(created, isA<Success<MissionAlert>>());
    expect(await container.read(myAlertsProvider.future), hasLength(4));
    await actions.delete('al1');
    expect(await container.read(myAlertsProvider.future), hasLength(3));
  });

  testWidgets('B04 → B16 : créer une alerte « plomberie »', (tester) async {
    await pumpWorkerApp(tester);
    await tester.enterText(find.byType(TextField).first, 'plomberie');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Créer une alerte « plomberie »'));
    await tester.pumpAndSettle();
    expect(find.text('Mes alertes'), findsOneWidget);
    expect(_alertTiles(), findsNWidgets(3));
    await tester.ensureVisible(find.text('Créer l’alerte'));
    await tester.pump();
    await tester.tap(find.text('Créer l’alerte'));
    await tester.pumpAndSettle();
    expect(find.text('Alerte créée'), findsOneWidget);
    expect(_alertTiles(), findsNWidgets(4));
  });

  testWidgets('Moi → Mes alertes', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Moi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mes alertes'));
    await tester.pumpAndSettle();
    expect(find.text('Nouvelle alerte'), findsOneWidget);
  });
}
