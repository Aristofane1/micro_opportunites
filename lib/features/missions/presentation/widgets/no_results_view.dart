import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:micro_opportunites/core/assets/app_images.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/filter_pill.dart';

/// Recherche sans résultat (B04).
class NoResultsView extends StatelessWidget {
  const NoResultsView({
    super.key,
    required this.query,
    required this.zoneLabel,
    required this.onCreateAlert,
    required this.onWiden,
    required this.onSuggestion,
  });

  static const suggestions = ['Réparation', 'Électricité', 'Bricolage'];

  final String query;

  /// « 5 km » ou « Cotonou ».
  final String zoneLabel;
  final VoidCallback onCreateAlert;

  /// `null` quand la zone est déjà au maximum.
  final VoidCallback? onWiden;
  final ValueChanged<String> onSuggestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        SvgPicture.asset(AppImages.emptyPin, height: 96),
        const SizedBox(height: 14),
        Text(
          'Aucune mission « $query » à $zoneLabel',
          textAlign: TextAlign.center,
          style: AppTypography.heading,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Élargissez la zone, ou créez une alerte : on vous prévient dès '
          'qu’une mission arrive.',
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(color: AppColors.toggleText),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Créer une alerte « $query »',
          onPressed: onCreateAlert,
        ),
        if (onWiden != null) ...[
          const SizedBox(height: 10),
          AppButton(
            label: 'Chercher à 20 km',
            variant: AppButtonVariant.secondary,
            onPressed: onWiden,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        const Text('Recherches proches', style: AppTypography.label),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          children: [
            for (final suggestion in suggestions)
              FilterPill(
                label: suggestion,
                onTap: () => onSuggestion(suggestion),
              ),
          ],
        ),
      ],
    );
  }
}
