import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

/// Bouton cloche 44 px de l'en-tête, avec pastille si non-lus.
class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
    required this.unreadCount,
    required this.onPressed,
  });

  final int unreadCount;
  final VoidCallback? onPressed;

  String get _semanticLabel => switch (unreadCount) {
    <= 0 => 'Notifications',
    1 => 'Notifications, 1 non lue',
    _ => 'Notifications, $unreadCount non lues',
  };

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: _semanticLabel,
      enabled: onPressed != null,
      excludeSemantics: true,
      onTap: onPressed,
      child: Material(
        color: AppColors.card,
        shape: const CircleBorder(side: BorderSide(color: AppColors.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: AppSizes.minTouchTarget,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const AppIcon(
                  AppIcons.notifications,
                  size: 20,
                  color: AppColors.ink,
                ),
                if (unreadCount > 0)
                  Positioned(
                    top: 9,
                    right: 10,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: AppColors.notificationDot,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.card, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
