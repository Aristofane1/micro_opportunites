import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import '../helpers/pump_worker_app.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('entrée complète : splash → … → Explorer avec le prénom saisi', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      size: const Size(1000, 1600),
      initialLocation: EntryPaths.splash,
      session: null,
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // A02–A04
    await _tap(tester, find.text('Passer'));

    // A05 : création de compte, puis directement A07
    await tester.enterText(find.byKey(const Key('email.field')), 'awa@demo.bj');
    await tester.enterText(find.byKey(const Key('password.field')), 'secret1');
    await _tap(tester, find.text('Créer mon compte'));

    // A07
    expect(find.text('Faisons connaissance'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Prénom'), 'Awa');
    await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Dossou');
    await _tap(tester, find.byKey(const Key('profile.birthDate')));
    await _tap(tester, find.text('CONFIRMER'));
    await _tap(tester, find.textContaining('J\'accepte les Conditions'));
    await _tap(tester, find.text('Continuer'));

    // A08 → A09 recto, verso, selfie → A11 (indicateur animé : jamais
    // pumpAndSettle sur A11)
    await _tap(tester, find.text('Photographier le recto'));
    await _tap(tester, find.byKey(const Key('camera.shutter')));
    expect(find.text('Photographier le verso'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('camera.shutter')));
    expect(find.text('Prenez un selfie'), findsOneWidget);
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Vérification en cours'), findsOneWidget);

    // A11 → A13 → A14 → Explorer
    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Trouver des missions'),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await _tap(tester, find.text('Trouver des missions'));
    await _tap(tester, find.text('C\'est parti'));
    expect(find.text('Missions près de toi'), findsOneWidget);
    expect(find.text('Bonjour Awa'), findsOneWidget);
  });
}
