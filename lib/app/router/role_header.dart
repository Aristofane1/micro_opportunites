import 'package:flutter/material.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/notification_button.dart';

/// En-tête commun à toutes les pages d'un profil : bascule de rôle + cloche
/// de notifications. Rendu une seule fois par [RoleShell], au-dessus de la
/// pile de navigation (et non par chaque page d'onglet).
class RoleHeader extends StatelessWidget {
  const RoleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      child: Row(
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: RoleSwitcher(),
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          NotificationButton(unreadCount: 0, onPressed: null),
        ],
      ),
    );
  }
}
