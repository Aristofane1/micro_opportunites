import 'package:flutter_test/flutter_test.dart';

import 'package:micro_opportunites/core/ui/widgets/state_views.dart';

import '../helpers/pump_worker_app.dart';

Future<void> _tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.pump();
  await tester.ensureVisible(find.text(text));
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('parcours complet : trouver → postuler → réaliser → être payé', (
    tester,
  ) async {
    await pumpWorkerApp(tester);

    // Trouver et postuler (B01 → B05 → B06 → B07)
    await _tapText(tester, 'Distribution de flyers au carrefour');
    await _tapText(tester, 'Postuler');
    await _tapText(tester, 'Envoyer ma candidature');
    expect(find.text('Candidature envoyée'), findsOneWidget);

    // Suivre (B08) puis l'offre reçue (B09)
    await _tapText(tester, 'Suivre mes candidatures');
    expect(find.text('En cours (5)'), findsOneWidget);
    await _tapText(tester, 'Réinstaller Windows sur un portable');
    await _tapText(tester, 'Je confirme, j’y serai');

    // Mission confirmée (B10) → en cours (B11) → fin (B12) → validation (B13)
    expect(find.text('Tankpè, rue des Écoles'), findsOneWidget);
    await _tapText(tester, 'Je suis arrivé');
    expect(find.text('EN COURS'), findsOneWidget);
    await _tapText(tester, 'J’ai terminé');
    await _tapText(tester, 'Envoyer et faire mon check-out');
    expect(find.text('Bravo, c’est envoyé'), findsOneWidget);

    // Gains (B14) → reçu (B15)
    await _tapText(tester, 'Voir mes gains');
    expect(find.text('Mes gains'), findsOneWidget);
    expect(find.text('À valider par l’annonceur'), findsOneWidget);
    await _tapText(tester, 'Configurer une box internet');
    expect(find.text('Reçu de versement'), findsOneWidget);
    expect(find.text('MO-2026-004812'), findsOneWidget);
  });

  testWidgets('avec latence : confirmer l’offre mène à B10 puis B11', (
    tester,
  ) async {
    await pumpWorkerApp(tester, latency: const Duration(milliseconds: 400));
    await _tapText(tester, 'Candidatures');
    await _tapText(tester, 'Réinstaller Windows sur un portable');
    await tester.ensureVisible(find.text('Je confirme, j’y serai'));
    await tester.pump();
    await tester.tap(find.text('Je confirme, j’y serai'));
    // Action terminée (400 ms), rechargement en cours : pas de spinner plein écran.
    await tester.pump(const Duration(milliseconds: 450));
    expect(find.byType(LoadingView), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('Je suis arrivé'), findsOneWidget);
  });
}
