import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/app/router/placeholder_page.dart';
import 'package:micro_opportunites/app/router/role_shell.dart';
import 'package:micro_opportunites/app/router/shell_tabs.dart';
import 'package:micro_opportunites/dev/design_system_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Clé du navigator racine, au-dessus des shells de profil. À passer en
/// `parentNavigatorKey` pour qu'une route plein écran (ex. un flux poussé
/// depuis un onglet) s'affiche par-dessus la barre de navigation plutôt que
/// dans la pile de l'onglet.
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Une route de shell n'est accessible qu'au rôle actif ; sinon on renvoie
/// vers l'accueil de ce rôle. C'est aussi ce qui fait naviguer la bascule.
String? redirectForRole(String location, ActiveRole role) {
  final locationRole = AppRoutes.roleOf(location);
  if (locationRole != null && locationRole != role) {
    return AppRoutes.homeFor(role);
  }
  return null;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final roleChanges = ValueNotifier<ActiveRole>(ref.read(activeRoleProvider));
  ref.listen(activeRoleProvider, (_, next) => roleChanges.value = next);

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.homeFor(roleChanges.value),
    refreshListenable: roleChanges,
    redirect: (_, state) =>
        redirectForRole(state.uri.path, ref.read(activeRoleProvider)),
    routes: [
      GoRoute(
        path: AppRoutes.root,
        redirect: (_, _) => AppRoutes.homeFor(ref.read(activeRoleProvider)),
      ),
      _roleShell(workerTabs),
      _roleShell(posterTabs),
      // Uniquement en debug : cet écran ne fait pas partie du produit livré.
      if (kDebugMode)
        GoRoute(
          path: AppRoutes.designSystem,
          builder: (_, _) => const DesignSystemPage(),
        ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    roleChanges.dispose();
  });
  return router;
}

StatefulShellRoute _roleShell(List<ShellTab> tabs) {
  return StatefulShellRoute.indexedStack(
    builder: (_, _, navigationShell) =>
        RoleShell(navigationShell: navigationShell, tabs: tabs),
    branches: [
      for (final tab in tabs)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: tab.path,
              builder: (context, _) =>
                  tab.builder?.call(context) ??
                  PlaceholderPage(
                    title: tab.label,
                    showDesignSystemLink: kDebugMode && tab.isProfile,
                  ),
              routes: tab.routes,
            ),
          ],
        ),
    ],
  );
}
