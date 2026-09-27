import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

enum FilterPillState {
  /// Catégorie non choisie.
  idle,

  /// Catégorie choisie (« Tout »).
  selected,

  /// Filtre actif retirable (« ≤ 5 km × »).
  applied,
}

class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.onTap,
    this.state = FilterPillState.idle,
  });

  final String label;
  final VoidCallback? onTap;
  final FilterPillState state;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, border) = switch (state) {
      FilterPillState.idle => (
        AppColors.card,
        AppColors.ink,
        AppColors.lineStrong,
      ),
      FilterPillState.selected => (
        AppColors.ink,
        AppColors.ivory,
        AppColors.ink,
      ),
      FilterPillState.applied => (
        AppColors.softGreen,
        AppColors.green,
        AppColors.green,
      ),
    };
    return MergeSemantics(
      child: Semantics(
        button: true,
        selected: state != FilterPillState.idle,
        hint: state == FilterPillState.applied ? 'Toucher pour retirer' : null,
        // Le visuel de la pastille reste à AppSizes.chipHeight (36 px) ;
        // ce padding porte la zone tactile à AppSizes.minTouchTarget (44 px).
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: (AppSizes.minTouchTarget - AppSizes.chipHeight) / 2,
            ),
            child: Material(
              color: background,
              shape: StadiumBorder(side: BorderSide(color: border)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: AppSizes.chipHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: AppTypography.label.copyWith(
                            color: foreground,
                          ),
                        ),
                        if (state == FilterPillState.applied) ...[
                          const SizedBox(width: 6),
                          AppIcon(AppIcons.close, size: 14, color: foreground),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
