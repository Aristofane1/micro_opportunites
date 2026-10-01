import 'package:flutter/material.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/notification_button.dart';

/// En-tête commun à toutes les pages racines d'un profil : bascule de rôle
/// + cloche de notifications. Rendu par [RoleShell].
class RoleHeader extends StatelessWidget {
  const RoleHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
