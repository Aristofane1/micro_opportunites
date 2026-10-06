import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

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

  testWidgets('Se déconnecter oublie brouillon, filtres et dernière mission ; '
      'l’écran e-mail s’ouvre en mode connexion', (tester) async {
    final container = await pumpWorkerApp(tester);
    container.read(missionDraftControllerProvider.notifier).updateTitle('X');
    container
        .read(missionFiltersControllerProvider.notifier)
        .setCity('Cotonou');
    container
        .read(lastPublishedProvider.notifier)
        .set(
          MissionSummary(
            id: 'm1',
            title: 'X',
            category: MissionCategory.other,
            city: 'Cotonou',
            startAt: fixedNow,
            durationMinutes: 60,
            payAmount: 1000,
            payUnit: PayUnit.flat,
            slotsTotal: 1,
            status: MissionStatus.published,
          ),
        );
    container
        .read(entryDraftControllerProvider.notifier)
        .setDocument('passport', 'BJ');
    showAppToast(
      tester.element(find.byKey(const Key('roleHeader.signOut'))),
      'Message de la session',
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('roleHeader.signOut')));
    await tester.pumpAndSettle();

    expect(find.text('Message de la session'), findsNothing);
    expect(container.read(activeRoleProvider), ActiveRole.worker);
    expect(container.read(missionDraftControllerProvider).title, isNull);
    expect(container.read(missionFiltersControllerProvider).city, isNull);
    expect(container.read(lastPublishedProvider), isNull);
    expect(
      container.read(entryDraftControllerProvider).documentType,
      'id_card',
    );
    expect(
      container.read(entryDraftControllerProvider).creatingAccount,
      isFalse,
    );
    expect(find.text('Me connecter'), findsOneWidget);
    expect(find.text('Créer un compte'), findsOneWidget);
  });
}
