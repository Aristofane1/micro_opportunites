import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import '../helpers/pump_worker_app.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _hint(String hint) => find.byWidgetPredicate(
  (w) => w is TextField && w.decoration?.hintText == hint,
);

Future<void> _tapText(WidgetTester tester, String text) =>
    _tap(tester, find.text(text).first);

void main() {
  testWidgets('parcours à deux comptes : publier → postuler → retenir → '
      'réaliser → valider → être payé', (tester) async {
    await pumpWorkerApp(
      tester,
      session: null,
      initialLocation: EntryPaths.email,
      size: const Size(1000, 1600),
    );

    Future<void> login(String email) async {
      // Laisse partir les messages éphémères de la session précédente.
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();
      await _tapText(tester, 'J’ai déjà un compte');
      await tester.enterText(find.byKey(const Key('email.field')), email);
      await tester.enterText(
        find.byKey(const Key('password.field')),
        'demo123',
      );
      await _tapText(tester, 'Me connecter');
    }

    // Le bouton de sortie est dans l'en-tête des onglets : on y revient d'abord.
    Future<void> logout(String tab) async {
      await _tapText(tester, tab);
      await _tap(tester, find.byKey(const Key('roleHeader.signOut')));
    }

    // 1. L'annonceur publie.
    await login('annonceur@demo.bj');
    await _tapText(tester, 'Publier');
    await _tapText(tester, 'Nouvelle mission');
    await tester.enterText(
      _hint('Ex. Distribution de flyers au carrefour'),
      'Aide déménagement',
    );
    await tester.enterText(
      _hint('Décris la mission : ce qu\'il y a à faire, le matériel fourni…'),
      'Porter des cartons.',
    );
    await _tapText(tester, 'Autre');
    await _tapText(tester, 'Suivant : où');
    await tester.enterText(_hint('Ex. Abomey-Calavi'), 'Abomey-Calavi');
    await tester.enterText(
      _hint('Ex. Rue de la pharmacie, Godomey'),
      'Rue 12, Tankpè',
    );
    await _tapText(tester, 'Suivant : quand et combien');
    // Date de la mission : le sélecteur propose demain (fin des candidatures
    // déduite par le brouillon).
    await _tapText(tester, 'Choisir');
    await _tapText(tester, 'OK');
    await tester.enterText(_hint('0'), '5000');
    await tester.pumpAndSettle();
    await _tap(tester, find.widgetWithText(FilledButton, 'Publier'));
    expect(find.text('Votre mission est en ligne'), findsOneWidget);
    await _tapText(tester, 'Suivre ma mission');
    await logout('Mes missions');

    // 2. L'exécutant postule ; l'adresse précise reste cachée.
    await login('executant@demo.bj');
    await _tapText(tester, 'Explorer');
    await _tapText(tester, 'Aide déménagement');
    expect(find.text('Rue 12, Tankpè'), findsNothing);
    await _tapText(tester, 'Postuler');
    await _tapText(tester, 'Envoyer ma candidature');
    expect(find.text('Candidature envoyée'), findsOneWidget);
    await _tapText(tester, 'Suivre mes candidatures');
    await logout('Candidatures');

    // 3. L'annonceur retient Rodrigue.
    await login('annonceur@demo.bj');
    await _tapText(tester, 'Mes missions');
    await _tapText(tester, 'Aide déménagement');
    await _tapText(tester, 'Candidats');
    expect(find.text('Rodrigue K.'), findsOneWidget);
    await _tap(tester, find.widgetWithText(FilledButton, 'Retenir').first);
    expect(find.textContaining('est retenu(e)'), findsOneWidget);
    await logout('Mes missions');

    // 4. L'exécutant confirme, voit l'adresse, pointe et signale la fin.
    await login('executant@demo.bj');
    await _tapText(tester, 'Candidatures');
    await _tapText(tester, 'Aide déménagement');
    await _tapText(tester, 'Je confirme, j’y serai');
    expect(find.text('Rue 12, Tankpè'), findsOneWidget);
    await _tapText(tester, 'Je suis arrivé');
    await _tapText(tester, 'J’ai terminé');
    await _tapText(tester, 'Envoyer et faire mon check-out');
    expect(find.text('Bravo, c’est envoyé'), findsOneWidget);
    await _tapText(tester, 'Voir mes gains');
    await logout('Explorer');

    // 5. L'annonceur valide et paie.
    await login('annonceur@demo.bj');
    await _tapText(tester, 'Mes missions');
    await _tapText(tester, 'Travail à valider');
    await _tap(
      tester,
      find.widgetWithText(
        FilledButton,
        'Valider et verser ${formatFcfa(5000)}',
      ),
    );
    await _tapText(tester, 'Paiements');
    expect(find.text(formatFcfa(195000)), findsWidgets);
    await logout('Mes missions');

    // 6. L'exécutant voit la ligne versée.
    await login('executant@demo.bj');
    await _tapText(tester, 'Gains');
    final row = find.ancestor(
      of: find.text('Aide déménagement'),
      matching: find.byWidgetPredicate(
        (w) => w.runtimeType.toString() == '_EarningRow',
      ),
    );
    expect(row, findsOneWidget);
    expect(
      find.descendant(of: row, matching: find.textContaining('Versé ·')),
      findsOneWidget,
    );
  });
}
