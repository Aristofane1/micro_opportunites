import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

import '../../support/fake_backend/fake_api_client.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

void main() {
  testWidgets('B06 sans pièce d’identité : bouton vers A08', (tester) async {
    final container = await pumpWorkerApp(
      tester,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).db.users['u1']!
              .remove('kyc'),
    );
    await tester.tap(find.text('Distribution de flyers au carrefour'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Postuler'));
    await tester.pumpAndSettle();
    expect(find.text('Envoyer ma pièce d’identité'), findsNothing);
    await tester.tap(find.text('Envoyer ma candidature'));
    await tester.pumpAndSettle();
    expect(find.text('Envoyer ma pièce d’identité'), findsOneWidget);
    await tester.tap(find.text('Envoyer ma pièce d’identité'));
    await tester.pumpAndSettle();
    // Ouverte par-dessus la candidature (push) : retour possible.
    expect(
      container
          .read(appRouterProvider)
          .routerDelegate
          .currentConfiguration
          .last
          .matchedLocation,
      EntryPaths.idDocument,
    );
    expect(find.text('Votre pièce d\'identité'), findsOneWidget);
  });

  testWidgets('B05 → B06 → B07 → B08 : postuler puis suivre', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Distribution de flyers au carrefour'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Postuler'));
    await tester.pumpAndSettle();
    expect(find.text('Un mot pour l’annonceur (facultatif)'), findsOneWidget);
    await tester.enterText(
      find.byType(TextField).last,
      'Disponible toute la journée.',
    );
    await tester.tap(find.text('Envoyer ma candidature'));
    await tester.pumpAndSettle();
    expect(find.text('Candidature envoyée'), findsOneWidget);
    expect(find.textContaining('Adjovi H. répond'), findsOneWidget);
    await tester.tap(find.text('Suivre mes candidatures'));
    await tester.pumpAndSettle();
    expect(find.text('Mes candidatures'), findsOneWidget);
    expect(find.text('En cours (5)'), findsOneWidget);
    expect(find.text('Distribution de flyers au carrefour'), findsOneWidget);
  });

  testWidgets('B08 : retirer une candidature en attente', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Candidatures'));
    await tester.pumpAndSettle();
    expect(find.text('En cours (4)'), findsOneWidget);
    expect(find.text('reste 11 h'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Retirer'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Retirer').last);
    await tester.pumpAndSettle();
    expect(find.text('Candidature retirée'), findsOneWidget);
    expect(find.text('En cours (3)'), findsOneWidget);
  });

  testWidgets('B09 : décliner une offre', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Candidatures'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Réinstaller Windows sur un portable'));
    await tester.pumpAndSettle();
    expect(find.text('Vous êtes retenu pour cette mission'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Je ne suis plus disponible'),
      200,
    );
    await tester.tap(find.text('Je ne suis plus disponible'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Décliner l’offre'));
    await tester.pumpAndSettle();
    expect(find.text('Offre déclinée'), findsOneWidget);
    expect(find.text('En cours (3)'), findsOneWidget);
  });

  testWidgets('Review focus : offre déjà confirmée → « plus disponible »', (
    tester,
  ) async {
    final container = await pumpWorkerApp(tester);
    container.read(appRouterProvider).push(WorkerPaths.offer('a2'));
    await tester.pumpAndSettle();
    expect(find.text('Cette offre n’est plus disponible'), findsOneWidget);
  });

  testWidgets('Review focus : offre expirée → « plus disponible »', (
    tester,
  ) async {
    // La base est semée à fixedNow (offre a1 : expire dans 11 h), puis le
    // temps avance de 12 h.
    var now = fixedNow;
    final container = await pumpWorkerApp(tester, clock: () => now);
    now = fixedNow.add(const Duration(hours: 12));
    container.read(appRouterProvider).push(WorkerPaths.offer('a1'));
    await tester.pumpAndSettle();
    expect(find.text('Cette offre n’est plus disponible'), findsOneWidget);
    expect(find.text('Je confirme, j’y serai'), findsNothing);
  });
}
