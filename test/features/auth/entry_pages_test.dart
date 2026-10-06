import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('A05 : e-mail vide → message, pas de navigation', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('Créer mon compte'));
    await tester.pumpAndSettle();
    expect(find.text('Saisissez votre e-mail.'), findsOneWidget);
  });

  testWidgets('A05 : connexion annonceur → Mes missions', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('J’ai déjà un compte'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email.field')),
      'annonceur@demo.bj',
    );
    await tester.enterText(find.byKey(const Key('password.field')), 'demo123');
    await tester.tap(find.text('Me connecter'));
    await tester.pumpAndSettle();
    expect(find.text('Mes missions'), findsWidgets);
  });

  testWidgets('A05 : mauvais mot de passe', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('J’ai déjà un compte'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email.field')),
      'annonceur@demo.bj',
    );
    await tester.enterText(find.byKey(const Key('password.field')), 'mauvais');
    await tester.tap(find.text('Me connecter'));
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou mot de passe incorrect.'), findsOneWidget);
  });
}
