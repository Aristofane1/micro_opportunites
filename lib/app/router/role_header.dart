import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/notification_button.dart';

/// En-tête commun à toutes les pages racines d'un profil : bascule de rôle
/// + cloche de notifications. Rendu par [RoleShell].
class RoleHeader extends ConsumerWidget {
  const RoleHeader({super.key});

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(authActionsProvider.notifier).logout();
    if (!context.mounted) return;
    switch (result) {
      case Err(:final failure):
        showAppToast(context, failure.message);
      case Success():
        ref.read(activeRoleProvider.notifier).switchTo(ActiveRole.worker);
        context.go(EntryPaths.email);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      child: Row(
        children: [
          const Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: RoleSwitcher(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          NotificationButton(
            unreadCount: 2,
            onPressed: () => showComingSoon(context, 'Notifications'),
          ),
          IconButton(
            key: const Key('roleHeader.signOut'),
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () => _signOut(context, ref),
          ),
        ],
      ),
    );
  }
}
