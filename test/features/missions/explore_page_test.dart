import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('B01 : salutation, titre, compteur et missions', (tester) async {
    await pumpWorkerApp(tester);
    expect(find.text('Bonjour Rodrigue'), findsOneWidget);
    expect(find.text('Missions près de toi'), findsOneWidget);
    expect(
      find.textContaining('7 missions', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('Mis à jour il y a 2 min'), findsOneWidget);
    expect(find.text('Distribution de flyers au carrefour'), findsOneWidget);
  });

  testWidgets('B01 : la puce Informatique filtre la liste', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Informatique'));
    await tester.pumpAndSettle();
    expect(find.text('Réinstaller Windows sur un portable'), findsOneWidget);
    expect(find.text('Distribution de flyers au carrefour'), findsNothing);
  });

  testWidgets('Review focus : une recherche blanche ne navigue pas', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    await tester.enterText(find.byType(TextField).first, '   ');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets('B04 : recherche sans résultat puis élargir à 20 km', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    await tester.enterText(find.byType(TextField).first, 'plomberie');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(find.text('Aucune mission « plomberie » à 5 km'), findsOneWidget);
    expect(find.text('Créer une alerte « plomberie »'), findsOneWidget);
    await tester.tap(find.text('Chercher à 20 km'));
    await tester.pumpAndSettle();
    expect(find.text('Aucune mission « plomberie » à 20 km'), findsOneWidget);
  });

  testWidgets('B03 : 20 km dans la feuille Filtres → 11 missions', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.byKey(const Key('explore.filters')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20 km'));
    await tester.pumpAndSettle();
    expect(find.text('Voir 11 missions'), findsOneWidget);
    await tester.tap(find.text('Voir 11 missions'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('11 missions', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('B02 : choisir une ville sur la carte', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Carte'));
    await tester.pumpAndSettle();
    expect(find.text('Abomey-Calavi · 7 missions'), findsOneWidget);
    await tester.tap(find.text('Voir les 7 missions'));
    await tester.pumpAndSettle();
    expect(find.text('Missions près de toi'), findsOneWidget);
    expect(
      find.textContaining('7 missions · Abomey-Calavi', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('B05 puis B17 : détail et profil de l’annonceur', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Distribution de flyers au carrefour'));
    await tester.pumpAndSettle();
    expect(find.text('Postuler'), findsOneWidget);
    expect(
      find.textContaining('Paiement garanti', findRichText: true),
      findsOneWidget,
    );
    await tester.ensureVisible(find.text('Adjovi H.'));
    await tester.pump();
    await tester.tap(find.text('Adjovi H.'));
    await tester.pumpAndSettle();
    expect(find.text('Avis des exécutants'), findsOneWidget);
    expect(find.text('Mireille A.'), findsOneWidget);
  });

  testWidgets('Review focus : erreur réseau puis « Réessayer »', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).nextError =
              const ApiException(0, 'hors-ligne'),
    );
    expect(find.text(const NetworkFailure().message), findsOneWidget);
    await tester.tap(find.text('Réessayer'));
    await tester.pumpAndSettle();
    expect(find.text('Distribution de flyers au carrefour'), findsOneWidget);
  });

  testWidgets('B05 : mission complète → bouton « Complet » désactivé', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient)
                  .db
                  .missions['m1']!['slotsFree'] =
              0,
    );
    await tester.tap(find.text('Distribution de flyers au carrefour'));
    await tester.pumpAndSettle();
    expect(find.text('Postuler'), findsNothing);
    final button = find.widgetWithText(AppButton, 'Complet');
    expect(button, findsOneWidget);
    expect(tester.widget<AppButton>(button).onPressed, isNull);
  });
}
