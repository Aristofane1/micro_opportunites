import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

enum AppButtonVariant {
  /// Action principale (vert Calavi).
  primary,

  /// Payer, verser (ocre profond).
  money,

  /// Contour vert.
  secondary,

  /// Contour neutre, texte rouge.
  destructive,
}

/// Bouton du design : 52 px de haut, arrondi 14. `onPressed` null =
/// désactivé ; `isLoading` garde l'apparence active mais ignore les appuis.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppIcons? icon;
  final bool isLoading;
  final bool expand;

  static void _ignoreTap() {}

  @override
  Widget build(BuildContext context) {
    final callback = onPressed == null
        ? null
        : (isLoading ? _ignoreTap : onPressed);
    final foreground = _foreground(enabled: onPressed != null);
    final Widget child = isLoading
        ? Semantics(
            label: '$label, en cours',
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: foreground,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                AppIcon(icon!, size: 20, color: foreground),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: callback,
        child: child,
      ),
      AppButtonVariant.money => FilledButton(
        onPressed: callback,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ochreDeep,
          foregroundColor: AppColors.white,
        ),
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        style: _outlined(border: AppColors.green, foreground: AppColors.green),
        child: child,
      ),
      AppButtonVariant.destructive => OutlinedButton(
        onPressed: callback,
        style: _outlined(
          border: AppColors.lineDashed,
          foreground: AppColors.red,
        ),
        child: child,
      ),
    };

    final sized = expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
    // Un bouton "en chargement" garde son apparence active (voir doc de
    // la classe) mais doit être annoncé comme non activé, pas comme
    // pressable, aux technologies d'assistance.
    return isLoading ? Semantics(enabled: false, child: sized) : sized;
  }

  Color _foreground({required bool enabled}) {
    if (!enabled) return AppColors.disabledForeground;
    return switch (variant) {
      AppButtonVariant.primary || AppButtonVariant.money => AppColors.white,
      AppButtonVariant.secondary => AppColors.green,
      AppButtonVariant.destructive => AppColors.red,
    };
  }

  static ButtonStyle _outlined({
    required Color border,
    required Color foreground,
  }) {
    return OutlinedButton.styleFrom(foregroundColor: foreground).copyWith(
      side: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? BorderSide.none
            : BorderSide(color: border),
      ),
    );
  }
}
