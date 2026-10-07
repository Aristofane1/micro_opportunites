import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import '../../support/fake_backend/fake_api_client.dart';
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
  testWidgets('sans session, le splash mène à l’onboarding', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      session: null,
    );
    expect(find.text('MicroOpportunités'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Passer'), findsOneWidget);
  });

  testWidgets('session exécutant : le splash mène à Explorer', (tester) async {
    final container = await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
    );
    expect(find.text('MicroOpportunités'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(container.read(activeRoleProvider), ActiveRole.worker);
    expect(find.text('Missions près de toi'), findsOneWidget);
    expect(find.text('Bonjour Rodrigue'), findsOneWidget);
  });

  testWidgets('réseau coupé : le splash reste, « Réessayer » reprend', (
    tester,
  ) async {
    final container = await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).nextError =
              const ApiException(0, 'Pas de connexion internet.'),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text(const NetworkFailure().message), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.text('Passer'), findsNothing);

    // Le faux serveur répond de nouveau (nextError ne sert qu'une fois).
    await tester.tap(find.text('Réessayer'));
    await tester.pumpAndSettle();
    expect(container.read(activeRoleProvider), ActiveRole.worker);
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets('reprise en échec : « Se déconnecter » mène à la connexion', (
    tester,
  ) async {
    final container = await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).nextError =
              const ApiException(0, 'Pas de connexion internet.'),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Réessayer'), findsOneWidget);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();
    expect(find.text('Me connecter'), findsOneWidget);
    expect(
      (container.read(apiClientProvider) as FakeApiClient).db.sessionUserId,
      isNull,
    );
  });

  testWidgets('serveur en panne : message du service, pas d’onboarding', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).nextError =
              const ApiException(503, 'indisponible'),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text(const ServerFailure().message), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('session refusée (401) : onboarding', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient).nextError =
              const ApiException(
                401,
                'Votre session a expiré. Reconnectez-vous.',
              ),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Passer'), findsOneWidget);
  });

  testWidgets('reprise lente : indicateur sous le logo au-delà de 2 s', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      latency: const Duration(seconds: 3),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(const Key('splash.loading')), findsNothing);
    await tester.pump(const Duration(milliseconds: 1100));
    expect(find.byKey(const Key('splash.loading')), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('splash.loading')), findsNothing);
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets('reprise rapide : pas d’indicateur', (tester) async {
    await pumpWorkerApp(tester, initialLocation: EntryPaths.splash);
    await tester.pump(const Duration(milliseconds: 1900));
    expect(find.byKey(const Key('splash.loading')), findsNothing);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byKey(const Key('splash.loading')), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets('session annonceur : le rôle enregistré est restauré', (
    tester,
  ) async {
    final container = await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      session: 'u10',
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(container.read(activeRoleProvider), ActiveRole.poster);
    expect(
      container
          .read(appRouterProvider)
          .routerDelegate
          .currentConfiguration
          .uri
          .path,
      '/poster/missions',
    );
  });

  testWidgets('profil incomplet : le splash reprend à A07', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient)
                  .db
                  .users['u1']!['firstName'] =
              '',
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Faisons connaissance'), findsOneWidget);
  });

  testWidgets('aucun rôle choisi : le splash reprend à A13', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.splash,
      beforePump: (container) =>
          (container.read(apiClientProvider) as FakeApiClient)
                  .db
                  .users['u1']!['role'] =
              null,
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Publier une mission'), findsOneWidget);
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
