import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/account/data/account_providers.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/email_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/permissions_page.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/usage_choice_page.dart';

/// A05 composé par l'app : après connexion, rôle du compte puis accueil.
class EntryEmail extends ConsumerWidget {
  const EntryEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => EmailPage(
    onSignedIn: (context, account) {
      final role = ActiveRole.values.asNameMap()[account.role];
      if (role == null) {
        context.go(EntryPaths.usage);
        return;
      }
      ref.read(activeRoleProvider.notifier).switchTo(role);
      context.go(AppRoutes.homeFor(role));
    },
  );
}

/// A13 composé par l'app : le choix règle le rôle actif.
class EntryUsageChoice extends ConsumerWidget {
  const EntryUsageChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> choose(ActiveRole role) async {
      final result = await ref
          .read(accountRepositoryProvider)
          .saveRole(role.name);
      if (!context.mounted) return;
      switch (result) {
        case Success():
          ref.read(activeRoleProvider.notifier).switchTo(role);
          context.go(EntryPaths.permissions);
        case Err(:final failure):
          showAppToast(context, failure.message);
      }
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
