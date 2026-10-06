import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('le splash mène à l’onboarding', (tester) async {
    await pumpWorkerApp(tester, initialLocation: EntryPaths.splash);
    expect(find.text('MicroOpportunités'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Passer'), findsOneWidget);
  });

  testWidgets('A13 « Trouver » puis A14 → Explorer (exécutant)', (
    tester,
  ) async {
    final container = await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.usage,
    );
    await tester.tap(find.text('Trouver des missions'));
    await tester.pumpAndSettle();
    expect(find.text('C\'est parti'), findsOneWidget);
    await tester.tap(find.text('C\'est parti'));
    await tester.pumpAndSettle();
    expect(container.read(activeRoleProvider), ActiveRole.worker);
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets(
    'Review focus : A13 « Publier » → A14 → Mes missions (annonceur)',
    (tester) async {
      final container = await pumpWorkerApp(
        tester,
        initialLocation: EntryPaths.usage,
      );
      await tester.tap(find.text('Publier une mission'));
      await tester.pumpAndSettle();
      expect(find.text('C\'est parti'), findsOneWidget);
      await tester.tap(find.text('Plus tard'));
      await tester.pumpAndSettle();
      expect(container.read(activeRoleProvider), ActiveRole.poster);
      expect(find.text('Mes missions'), findsWidgets);
      expect(
        container
            .read(appRouterProvider)
            .routerDelegate
            .currentConfiguration
            .uri
            .path,
        '/poster/missions',
      );
    },
  );

  testWidgets('Se déconnecter → écran e-mail ; route protégée refusée', (
    tester,
  ) async {
    final container = await pumpWorkerApp(tester);
    await tester.tap(find.byKey(const Key('roleHeader.signOut')));
    await tester.pumpAndSettle();
    expect(find.text('Votre e-mail'), findsOneWidget);
    expect(
      (container.read(apiClientProvider) as FakeApiClient).db.sessionUserId,
      isNull,
    );
  });
}
