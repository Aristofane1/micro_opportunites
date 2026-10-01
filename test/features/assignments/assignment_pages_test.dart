import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('B10 → B11 → B12 → B13', (tester) async {
    final container = await pumpWorkerApp(tester);
    container.read(appRouterProvider).push(WorkerPaths.assignment('as1'));
    await tester.pumpAndSettle();
    expect(find.text('Godomey, rue de la pharmacie'), findsOneWidget);
    expect(find.textContaining('Repère :'), findsOneWidget);
    await tester.ensureVisible(find.text('Je suis arrivé'));
    await tester.tap(find.text('Je suis arrivé'));
    await tester.pumpAndSettle();
    expect(find.text('EN COURS'), findsOneWidget);
    await tester.ensureVisible(find.text('J’ai terminé'));
    await tester.tap(find.text('J’ai terminé'));
    await tester.pumpAndSettle();
    expect(find.text('Signaler la fin'), findsOneWidget);
    await tester.enterText(
      find.byType(TextField),
      'Invités accueillis, badges rendus.',
    );
    await tester.tap(find.text('Envoyer et faire mon check-out'));
    await tester.pumpAndSettle();
    expect(find.text('Bravo, c’est envoyé'), findsOneWidget);
    expect(find.text('Validation par l’annonceur'), findsOneWidget);
  });

  testWidgets('B10 : se désister ramène à Mes candidatures', (tester) async {
    final container = await pumpWorkerApp(tester);
    container.read(appRouterProvider).push(WorkerPaths.assignment('as1'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Me désister'));
    await tester.tap(find.text('Me désister'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Me désister').last);
    await tester.pumpAndSettle();
    expect(find.text('Vous vous êtes désisté'), findsOneWidget);
    expect(find.text('Mes candidatures'), findsOneWidget);
  });
}
