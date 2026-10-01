import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';

/// Ouvre la feuille Filtres (B03).
Future<void> showMissionFiltersSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => const MissionFiltersSheet(),
    );

/// Feuille Filtres : brouillon local, compte en direct, application au clic.
class MissionFiltersSheet extends ConsumerStatefulWidget {
  const MissionFiltersSheet({super.key});

  @override
  ConsumerState<MissionFiltersSheet> createState() =>
      _MissionFiltersSheetState();
}

class _MissionFiltersSheetState extends ConsumerState<MissionFiltersSheet> {
  late MissionFilters _draft = ref.read(missionFiltersControllerProvider);
  late final _minPayController = TextEditingController(
    text: _draft.minPay?.toString() ?? '',
  );

  @override
  void dispose() {
    _minPayController.dispose();
    super.dispose();
  }

  void _update(MissionFilters draft) => setState(() => _draft = draft);

  void _toggleCategory(MissionCategory category) {
    final categories = {..._draft.categories};
    if (!categories.remove(category)) categories.add(category);
    _update(_draft.copyWith(categories: categories));
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(filtersPreviewCountProvider(_draft)).value;
    final label = switch (count) {
      null => 'Voir les missions',
      1 => 'Voir 1 mission',
      _ => 'Voir $count missions',
    };
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screen,
                0,
                AppSpacing.screen,
                AppSpacing.md,
              ),
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('Filtres', style: AppTypography.heading),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.ochreDeep,
                      ),
                      onPressed: () {
                        _minPayController.clear();
                        _update(const MissionFilters());
                      },
                      child: const Text('Réinitialiser'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text('Distance', style: AppTypography.bodyStrong),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final km in MissionFilters.radiusOptions) ...[
                      if (km != MissionFilters.radiusOptions.first)
                        const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: _OptionTile(
                          label: '$km km',
                          selected:
                              _draft.city == null && _draft.radiusKm == km,
                          onTap: () => _update(
                            _draft.copyWith(radiusKm: km, city: null),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_draft.city != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Ville choisie sur la carte : ${_draft.city}',
                    style: AppTypography.caption,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                const Text('Catégories', style: AppTypography.bodyStrong),
                const SizedBox(height: 10),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final category in MissionCategory.values)
                      if (category != MissionCategory.other)
                        _CategoryChip(
                          label: category.label,
                          selected: _draft.categories.contains(category),
                          onTap: () => _toggleCategory(category),
                        ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Rémunération minimum (FCFA)',
                  hint: 'Peu importe',
                  controller: _minPayController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) =>
                      _update(_draft.copyWith(minPay: int.tryParse(value))),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text('Quand', style: AppTypography.bodyStrong),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final period in MissionPeriod.values) ...[
                      if (period != MissionPeriod.values.first)
                        const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: _OptionTile(
                          label: period.label,
                          selected: _draft.period == period,
                          onTap: () => _update(_draft.copyWith(period: period)),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                MergeSemantics(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Plusieurs places seulement',
                              style: AppTypography.bodyStrong,
                            ),
                            Text(
                              'Pour y aller entre amis',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _draft.multiSlotsOnly,
                        onChanged: (value) =>
                            _update(_draft.copyWith(multiSlotsOnly: value)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              14,
              AppSpacing.screen,
              20,
            ),
            child: AppButton(
              label: label,
              onPressed: () {
                ref
                    .read(missionFiltersControllerProvider.notifier)
                    .apply(_draft);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.softGreen : AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.fieldAll,
          side: BorderSide(
            color: selected ? AppColors.green : AppColors.lineStrong,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: AppSizes.minTouchTarget,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    maxLines: 1,
                    style: AppTypography.label.copyWith(
                      color: selected ? AppColors.green : AppColors.ink,
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

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.softGreen : AppColors.card,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? AppColors.green : AppColors.lineStrong,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppSizes.minTouchTarget,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selected ? '✓ $label' : label,
                    style: AppTypography.label.copyWith(
                      color: selected ? AppColors.green : AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
