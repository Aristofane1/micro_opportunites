import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/pump_worker_app.dart';

String _location(ProviderContainer container) => container
    .read(appRouterProvider)
    .routerDelegate
    .currentConfiguration
    .uri
    .path;

void main() {
  group('redirectForRole', () {
    test('laisse passer une route du rôle actif', () {
      expect(
        redirectForRole(AppRoutes.workerEarnings, ActiveRole.worker),
        isNull,
      );
    });
    test('renvoie vers l’accueil du rôle actif', () {
      expect(
        redirectForRole(AppRoutes.posterPayments, ActiveRole.worker),
        AppRoutes.workerExplore,
      );
      expect(
        redirectForRole(AppRoutes.workerExplore, ActiveRole.poster),
        AppRoutes.posterMissions,
      );
    });
    test('ignore les routes hors shell', () {
      expect(redirectForRole('/autre-page', ActiveRole.poster), isNull);
    });
  });

  testWidgets('démarre sur Explorer (exécutant)', (tester) async {
    await pumpWorkerApp(tester);
    expect(find.text('Missions près de toi'), findsOneWidget);
    expect(find.text('Candidatures'), findsOneWidget);
    expect(find.text('Explorer'), findsOneWidget);
  });

  testWidgets('la bascule Annonceur affiche la navigation annonceur', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Annonceur'));
    await tester.pumpAndSettle();
    expect(find.text('Paiements'), findsOneWidget);
    expect(find.text('Mes missions'), findsNWidgets(2));
    expect(find.text('Candidatures'), findsNothing);
  });

  testWidgets('la bascule de rôle vit dans le shell, une seule fois par page', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    expect(find.byType(RoleSwitcher), findsOneWidget);
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.byType(RoleSwitcher), findsOneWidget);
  });

  testWidgets('pas d’en-tête de rôle hors de la racine d’un onglet', (
    tester,
  ) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Carte'));
    await tester.pumpAndSettle();
    expect(find.byType(RoleSwitcher), findsNothing);
  });

  testWidgets('Review focus : lien vers le shell de l’autre rôle redirigé', (
    tester,
  ) async {
    final container = await pumpWorkerApp(tester);
    container.read(appRouterProvider).go(AppRoutes.posterPayments);
    await tester.pumpAndSettle();
    expect(_location(container), AppRoutes.workerExplore);
  });

  testWidgets('Review focus : 320 px + texte ×1,5 sans débordement', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpWorkerApp(tester, size: const Size(320, 640));
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Candidatures'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Annonceur'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
