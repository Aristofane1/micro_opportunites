import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('A05 : pas de débordement avec le clavier ouvert', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
      size: const Size(360, 640),
    );
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    final button = find.text('Créer mon compte');
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
