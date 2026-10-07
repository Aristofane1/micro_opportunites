import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/account/data/account_providers.dart';
import 'package:micro_opportunites/features/auth/data/auth_providers.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/email_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/app/router/entry_resume.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/permissions_page.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/usage_choice_page.dart';

/// A01 composé par l'app : reprend là où la session en est restée. Sans
/// session (ou session refusée) → onboarding ; sinon la règle de reprise
/// commune avec la connexion ([resumeEntry]). Réseau ou serveur en échec :
/// on reste, avec « Réessayer » (ou « Se déconnecter »).
class EntrySplash extends ConsumerWidget {
  const EntrySplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(accountRepositoryProvider);
    final auth = ref.read(authRepositoryProvider);
    final activeRole = ref.read(activeRoleProvider.notifier);
    return SplashScreen(
      resolveNext: () async {
        switch (await repository.fetchCurrentUser()) {
          case Err(failure: UnauthorizedFailure()):
            return const SplashGo(EntryPaths.onboarding);
          case Err(:final failure):
            return SplashRetry(failure.message);
          case Success(value: final user):
            final next = await resumeEntry(
              auth: auth,
              activeRole: activeRole,
              firstName: user.firstName,
              role: user.role,
            );
            return switch (next) {
              Success(value: final path) => SplashGo(path),
              Err(failure: UnauthorizedFailure()) => const SplashGo(
                EntryPaths.onboarding,
              ),
              Err(:final failure) => SplashRetry(failure.message),
            };
        }
      },
      onSignOut: () async {
        // La session locale est effacée même si le serveur ne répond pas ;
        // l'écran e-mail s'ouvre en mode connexion.
        await auth.logout();
        ref
            .read(entryDraftControllerProvider.notifier)
            .setCreatingAccount(false);
        if (context.mounted) context.go(EntryPaths.email);
      },
    );
  }
}

/// A05 composé par l'app : après connexion, la règle de reprise commune
/// avec le splash ([resumeEntry]).
class EntryEmail extends ConsumerWidget {
  const EntryEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => EmailPage(
    onSignedIn: (context, account) async {
      final next = await resumeEntry(
        auth: ref.read(authRepositoryProvider),
        activeRole: ref.read(activeRoleProvider.notifier),
        firstName: account.firstName,
        role: account.role,
      );
      if (!context.mounted) return;
      switch (next) {
        case Success(value: final path):
          context.go(path);
        case Err(:final failure):
          showAppToast(context, failure.message);
      }
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
