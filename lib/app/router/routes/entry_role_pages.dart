import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/permissions_page.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/usage_choice_page.dart';

/// A13 composé par l'app : le choix règle le rôle actif.
class EntryUsageChoice extends ConsumerWidget {
  const EntryUsageChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void choose(ActiveRole role) {
      ref.read(activeRoleProvider.notifier).switchTo(role);
      context.go(EntryPaths.permissions);
    }

    return UsageChoicePage(
      onFindMissions: () => choose(ActiveRole.worker),
      onPublishMission: () => choose(ActiveRole.poster),
    );
  }
}

/// A14 composé par l'app : fin de l'entrée vers l'accueil du rôle actif.
class EntryPermissions extends ConsumerWidget {
  const EntryPermissions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PermissionsPage(
      onDone: () => context.go(AppRoutes.homeFor(ref.read(activeRoleProvider))),
    );
  }
}
