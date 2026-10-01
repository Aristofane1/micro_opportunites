import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/core/ui/widgets/filter_pill.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/widgets/filters_sheet.dart';
import 'package:micro_opportunites/features/missions/presentation/widgets/mission_card.dart';

/// Explorer (B01) : missions près de soi, recherche, filtres, carte.
class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key, this.greeting});

  /// Salutation fournie par l'app (feature account).
  final Widget? greeting;

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final _searchController = TextEditingController();

  static const _screenPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.screen,
  );

  static const _quickCategories = [
    MissionCategory.event,
    MissionCategory.computer,
    MissionCategory.shopping,
    MissionCategory.cleaning,
    MissionCategory.delivery,
    MissionCategory.dataEntry,
    MissionCategory.repair,
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch(String value) {
    final query = value.trim();
    if (query.isEmpty) return;
    _searchController.clear();
    FocusScope.of(context).unfocus();
    context.push(WorkerPaths.exploreSearch(query));
  }

  Future<void> _refresh() async {
    try {
      ref.invalidate(exploreMissionsProvider);
      await ref.read(exploreMissionsProvider.future);
    } catch (_) {
      // L'erreur est affichée par ErrorView.
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(missionFiltersControllerProvider);
    final missions = ref.watch(exploreMissionsProvider);
    final now = ref.watch(clockProvider)();
    final filtersNotifier = ref.read(missionFiltersControllerProvider.notifier);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        // Pas de marge horizontale : la rangée de puces va jusqu'aux bords
        // de l'écran, les autres blocs portent leur propre marge.
        padding: const EdgeInsets.only(
          top: AppSpacing.md,
          bottom: AppSpacing.xl,
        ),
        children: [
          Padding(
            padding: _screenPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ?widget.greeting,
                      Text(
                        'Missions près de toi',
                        style: AppTypography.title.copyWith(fontSize: 26),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _PillButton(
                  icon: AppIcons.map,
                  label: 'Carte',
                  onPressed: () => context.push(WorkerPaths.exploreMap),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: _screenPadding,
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: 'Rechercher',
                    textField: true,
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _submitSearch,
                      style: AppTypography.body,
                      decoration: const InputDecoration(
                        hintText: 'flyers, ménage, PC…',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 14, right: 10),
                          child: AppIcon(
                            AppIcons.search,
                            size: 18,
                            color: AppColors.inkSecondary,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 42),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                _FiltersButton(
                  activeCount: filters.activeCount,
                  onPressed: () => showMissionFiltersSheet(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: AppSizes.minTouchTarget,
            child: ListView(
              padding: _screenPadding,
              scrollDirection: Axis.horizontal,
              children: [
                if (filters.city != null) ...[
                  FilterPill(
                    label: filters.city!,
                    state: FilterPillState.applied,
                    onTap: () => filtersNotifier.setCity(null),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
                FilterPill(
                  label: 'Tout',
                  state: filters.categories.isEmpty
                      ? FilterPillState.selected
                      : FilterPillState.idle,
                  onTap: () => filtersNotifier.selectQuickCategory(null),
                ),
                for (final category in _quickCategories) ...[
                  const SizedBox(width: AppSpacing.xs),
                  FilterPill(
                    label: category.label,
                    state:
                        filters.categories.length == 1 &&
                            filters.categories.contains(category)
                        ? FilterPillState.selected
                        : FilterPillState.idle,
                    onTap: () => filtersNotifier.selectQuickCategory(category),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: _screenPadding,
            child: AsyncValueView<MissionPage>(
              value: missions,
              onRetry: () => ref.invalidate(exploreMissionsProvider),
              data: (page) => _MissionList(
                page: page,
                filters: filters,
                now: now,
                onReset: filtersNotifier.reset,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionList extends StatelessWidget {
  const _MissionList({
    required this.page,
    required this.filters,
    required this.now,
    required this.onReset,
  });

  final MissionPage page;
  final MissionFilters filters;
  final DateTime now;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final count = page.total == 1 ? '1 mission' : '${page.total} missions';
    final zone = filters.city ?? '${page.radiusKm} km autour';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 4,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: count,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  TextSpan(text: ' · $zone'),
                ],
              ),
              style: AppTypography.caption,
            ),
            Text(
              'Mis à jour ${formatRelativePast(page.updatedAt, now)}',
              style: AppTypography.caption,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (page.items.isEmpty)
          EmptyState(
            title: 'Aucune mission ici pour l’instant',
            message: 'Élargissez la zone ou retirez des filtres.',
            actionLabel: 'Réinitialiser les filtres',
            onAction: onReset,
          )
        else
          for (final mission in page.items) ...[
            MissionCard(
              mission: mission,
              now: now,
              onTap: () => context.push(WorkerPaths.missionDetail(mission.id)),
            ),
            const SizedBox(height: 10),
          ],
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final AppIcons icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.green)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSizes.minTouchTarget),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(icon, size: 16, color: AppColors.green),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppTypography.label.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
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

class _FiltersButton extends StatelessWidget {
  const _FiltersButton({required this.activeCount, required this.onPressed});

  final int activeCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: activeCount == 0 ? 'Filtres' : 'Filtres, $activeCount actifs',
      onTap: onPressed,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: 48,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Material(
                key: const Key('explore.filters'),
                color: AppColors.ink,
                borderRadius: AppRadius.tileAll,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onPressed,
                  child: const Center(
                    child: AppIcon(
                      AppIcons.filters,
                      size: 20,
                      color: AppColors.ivory,
                    ),
                  ),
                ),
              ),
            ),
            if (activeCount > 0)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 18),
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.ochre,
                    borderRadius: AppRadius.pillAll,
                  ),
                  child: Text(
                    '$activeCount',
                    style: AppTypography.navLabel.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
