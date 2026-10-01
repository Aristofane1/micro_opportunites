import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

/// Bouton rond 44 px (retour, partager, signaler…) des planches B.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.background = AppColors.card,
  });

  final AppIcons icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      onTap: onPressed,
      excludeSemantics: true,
      child: Material(
        color: background,
        shape: const CircleBorder(side: BorderSide(color: AppColors.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: AppSizes.minTouchTarget,
            child: Center(child: AppIcon(icon, size: 20, color: AppColors.ink)),
          ),
        ),
      ),
    );
  }
}
