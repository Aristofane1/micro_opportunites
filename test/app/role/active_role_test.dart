import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';

import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';

import '../../helpers/pump_worker_app.dart';

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

  testWidgets('RoleSwitcher change le rôle actif et l’enregistre', (
    tester,
  ) async {
    final container = createTestContainer();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: RoleSwitcher())),
      ),
    );
    await tester.tap(find.text('Annonceur'));
    await tester.pump();
    expect(container.read(activeRoleProvider), ActiveRole.poster);
    await tester.pumpAndSettle();
    expect(
      (container.read(apiClientProvider) as FakeApiClient)
          .db
          .currentUser['role'],
      'poster',
    );
    await tester.tap(find.text('Annonceur'));
    await tester.pumpAndSettle();
    expect(container.read(activeRoleProvider), ActiveRole.poster);
  });
}
