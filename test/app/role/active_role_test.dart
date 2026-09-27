import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';

import '../../helpers/pump_app.dart';

void main() {
  test('rôle initial Exécutant, bascule vers Annonceur', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(activeRoleProvider), ActiveRole.worker);
    container.read(activeRoleProvider.notifier).switchTo(ActiveRole.poster);
    expect(container.read(activeRoleProvider), ActiveRole.poster);
  });

  test('libellés et rôle opposé', () {
    expect(ActiveRole.worker.label, 'Exécutant');
    expect(ActiveRole.poster.label, 'Annonceur');
    expect(ActiveRole.worker.other, ActiveRole.poster);
  });

  test('Review focus : rebasculer sur le rôle actif ne notifie pas', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    var notifications = 0;
    container.listen(activeRoleProvider, (_, _) => notifications++);
    container.read(activeRoleProvider.notifier).switchTo(ActiveRole.worker);
    expect(notifications, 0);
  });

  testWidgets('RoleSwitcher change le rôle actif', (tester) async {
    await tester.pumpThemed(const RoleSwitcher());
    final container = ProviderScope.containerOf(
      tester.element(find.byType(RoleSwitcher)),
    );
    await tester.tap(find.text('Annonceur'));
    await tester.pump();
    expect(container.read(activeRoleProvider), ActiveRole.poster);
    await tester.tap(find.text('Annonceur'));
    await tester.pump();
    expect(container.read(activeRoleProvider), ActiveRole.poster);
  });
}
