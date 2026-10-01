import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/widgets/mission_card.dart';
import 'package:micro_opportunites/features/missions/presentation/widgets/no_results_view.dart';

/// Résultats de recherche ; B04 quand rien ne correspond.
class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key, required this.query});

  final String query;

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late final _controller = TextEditingController(text: widget.query);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String value) {
    final query = value.trim();
    if (query.isEmpty || query == widget.query) return;
    context.pushReplacement(WorkerPaths.exploreSearch(query));
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchMissionsProvider(widget.query));
    final filters = ref.watch(missionFiltersControllerProvider);
    final now = ref.watch(clockProvider)();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Row(
          children: [
            RoundIconButton(
              icon: AppIcons.back,
              semanticLabel: 'Retour',
              onPressed: () => context.pop(),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Semantics(
                label: 'Rechercher',
                textField: true,
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _search,
                  style: AppTypography.body,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher une mission',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncValueView<MissionPage>(
          value: results,
          onRetry: () => ref.invalidate(searchMissionsProvider(widget.query)),
          data: (page) {
            if (page.total == 0) {
              return NoResultsView(
                query: widget.query,
                zoneLabel: filters.city ?? '${page.radiusKm} km',
                onCreateAlert: () =>
                    context.push(WorkerPaths.alerts(keyword: widget.query)),
                onWiden: filters.city == null && page.radiusKm < 20
                    ? () => ref
                          .read(missionFiltersControllerProvider.notifier)
                          .apply(filters.copyWith(radiusKm: 20))
                    : null,
                onSuggestion: _search,
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  page.total == 1
                      ? '1 mission pour « ${widget.query} »'
                      : '${page.total} missions pour « ${widget.query} »',
                  style: AppTypography.label,
                ),
                const SizedBox(height: 10),
                for (final mission in page.items) ...[
                  MissionCard(
                    mission: mission,
                    now: now,
                    onTap: () =>
                        context.push(WorkerPaths.missionDetail(mission.id)),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
