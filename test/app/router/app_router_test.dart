import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';

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
      expect(
        redirectForRole(AppRoutes.designSystem, ActiveRole.poster),
        isNull,
      );
    });
  });

  testWidgets('démarre sur Explorer (exécutant)', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    expect(find.text('Candidatures'), findsOneWidget);
    expect(find.text('Gains'), findsOneWidget);
    expect(find.text('Explorer'), findsNWidgets(2));
  });

  testWidgets('la bascule Annonceur affiche la navigation annonceur', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annonceur'));
    await tester.pumpAndSettle();
    expect(find.text('Paiements'), findsOneWidget);
    expect(find.text('Mes missions'), findsNWidgets(2));
    expect(find.text('Candidatures'), findsNothing);
  });

  testWidgets('changer d’onglet affiche la page correspondante', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gains'));
    await tester.pumpAndSettle();
    expect(find.text('Gains'), findsNWidgets(2));
  });

  testWidgets(
    'I1 : la bascule de rôle vit dans le shell, une seule fois par page',
    (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await tester.pumpAndSettle();
      expect(find.byType(RoleSwitcher), findsOneWidget);

      await tester.tap(find.text('Gains'));
      await tester.pumpAndSettle();
      expect(find.byType(RoleSwitcher), findsOneWidget);
    },
  );

  testWidgets('Review focus : lien vers le shell de l’autre rôle redirigé', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const App()),
    );
    await tester.pumpAndSettle();
    container.read(appRouterProvider).go(AppRoutes.posterPayments);
    await tester.pumpAndSettle();
    expect(_location(container), AppRoutes.workerExplore);
  });

  testWidgets('Review focus : 320 px + texte ×1,5 sans débordement', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Annonceur'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
