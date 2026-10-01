import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('Review focus : « Envoyer le code » sans numéro', (tester) async {
    await pumpWorkerApp(tester, initialLocation: EntryPaths.phone);
    await tester.tap(find.text('Envoyer le code'));
    await tester.pumpAndSettle();
    expect(find.text('Saisissez votre numéro.'), findsOneWidget);
    expect(find.text('Entrez le code reçu'), findsNothing);
  });

  testWidgets('Review focus : mauvais code SMS', (tester) async {
    await pumpWorkerApp(tester, initialLocation: EntryPaths.phone);
    await tester.enterText(find.byType(TextField).first, '97123456');
    await tester.tap(find.text('Envoyer le code'));
    await tester.pumpAndSettle();
    expect(find.text('Code de démonstration : 12345'), findsOneWidget);
    for (var i = 0; i < 5; i++) {
      await tester.enterText(find.byKey(Key('otp.digit.$i')), '0');
    }
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    expect(find.text('Code incorrect.'), findsOneWidget);
    expect(find.text('Entrez le code reçu'), findsOneWidget);
  });
}
