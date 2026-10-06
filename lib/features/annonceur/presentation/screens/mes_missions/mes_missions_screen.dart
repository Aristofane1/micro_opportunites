import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/mission_card.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class MesMissionsScreen extends ConsumerWidget {
  const MesMissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending =
        ref.watch(pendingValidationsProvider).value ??
        const <PendingValidation>[];

    return AsyncValueView(
      value: ref.watch(myMissionsProvider),
      onRetry: () => ref.invalidate(myMissionsProvider),
      data: (missions) {
        // On répartit les missions dans les onglets selon leur statut
        final active = missions.where((m) => m.status.isActive).toList()
          ..sort(
            (a, b) => a.startAt.compareTo(b.startAt),
          ); // la plus proche d'abord
        final past = missions.where((m) => m.status.isPast).toList();

        return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Text(
                  'Mes missions',
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (pending.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: _ValidationBanner(
                    pending: pending,
                    now: ref.watch(clockProvider)(),
                    onTap: () => context.push(
                      PosterPaths.validate(
                        pending.first.missionId,
                        pending.first.candidate.assignmentId!,
                      ),
                    ),
                  ),
                ),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  Tab(text: 'Actives (${active.length})'),
                  const Tab(text: 'Passées'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _MissionList(
                      missions: active,
                      emptyText: 'Aucune mission active pour le moment.',
                      showPublishButton: true,
                    ),
                    _MissionList(
                      missions: past,
                      emptyText: 'Aucune mission passée.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MissionList extends StatelessWidget {
  const _MissionList({
    required this.missions,
    required this.emptyText,
    this.showPublishButton = false,
  });

  final List<MissionSummary> missions;
  final String emptyText;
  final bool showPublishButton;

  @override
  Widget build(BuildContext context) {
    if (missions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emptyText),
            if (showPublishButton) ...[
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go(PosterPaths.publish),
                child: const Text('Publier une mission'),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: missions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final mission = missions[index];
        return MissionCard(
          mission: mission,
          onTap: () => context.push(PosterPaths.missionManage(mission.id)),
        );
      },
    );
  }
}

class _ValidationBanner extends StatelessWidget {
  const _ValidationBanner({
    required this.pending,
    required this.now,
    required this.onTap,
  });

  final List<PendingValidation> pending;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const blue = AppColors.blue;
    final first = pending.first.candidate;
    final hoursLeft = first.autoPayAt?.difference(now).inHours;
    final when = (hoursLeft == null || hoursLeft <= 0)
        ? 'paiement automatique imminent'
        : 'paiement auto dans $hoursLeft h';

    return Material(
      color: blue,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${pending.length}',
                  style: const TextStyle(
                    color: blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Travail à valider',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${first.name} a terminé · $when',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.white),
            ],
          ),
        ),
      ),
    );
  }
}
