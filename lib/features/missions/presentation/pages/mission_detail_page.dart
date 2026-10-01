import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_avatar.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_detail_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/widgets/category_icon.dart';

/// Détail d'une mission (B05), plein écran.
class MissionDetailPage extends ConsumerWidget {
  const MissionDetailPage({super.key, required this.missionId});

  final String missionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mission = ref.watch(missionDetailProvider(missionId));
    final now = ref.watch(clockProvider)();
    return Scaffold(
      appBar: mission.hasValue ? null : AppBar(),
      body: AsyncValueView<Mission>(
        value: mission,
        onRetry: () => ref.invalidate(missionDetailProvider(missionId)),
        data: (value) => _DetailBody(mission: value, now: now),
      ),
      bottomNavigationBar: switch (mission) {
        AsyncData(:final value) => _ApplyBar(mission: value),
        _ => null,
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.mission, required this.now});

  final Mission mission;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final poster = mission.poster;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 150 + topInset,
          child: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(color: AppColors.softGreen),
              ),
              Positioned.fill(
                top: topInset,
                child: Center(
                  child: AppIcon(
                    missionCategoryIcon(mission.category),
                    size: 56,
                    color: AppColors.green,
                  ),
                ),
              ),
              Positioned(
                top: topInset + AppSpacing.xs,
                left: AppSpacing.md,
                right: AppSpacing.md,
                child: Row(
                  children: [
                    RoundIconButton(
                      icon: AppIcons.back,
                      semanticLabel: 'Retour',
                      onPressed: () => context.pop(),
                    ),
                    const Spacer(),
                    RoundIconButton(
                      icon: AppIcons.share,
                      semanticLabel: 'Partager',
                      onPressed: () => showComingSoon(context, 'Partage'),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    RoundIconButton(
                      icon: AppIcons.report,
                      semanticLabel: 'Signaler cette mission',
                      onPressed: () => showComingSoon(context, 'Signalement'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      mission.category.label.toUpperCase(),
                      style: AppTypography.small.copyWith(
                        color: AppColors.ochreDeep,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const StatusBadge(MissionStatusKind.published),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                mission.title,
                style: AppTypography.title.copyWith(fontSize: 26, height: 1.15),
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: AppSpacing.xs,
                children: [
                  Text(
                    formatFcfa(mission.payAmount),
                    style: AppTypography.amount.copyWith(fontSize: 28),
                  ),
                  Text(
                    'par personne · forfait',
                    style: AppTypography.caption.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      label: 'Date',
                      value:
                          '${formatShortDay(mission.startAt)} · ${formatHour(mission.startAt)}',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _InfoTile(
                      label: 'Durée',
                      value: formatDuration(mission.duration),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(label: 'Lieu', value: mission.city),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _InfoTile(
                      label: 'Places',
                      value: mission.slotsFree > 1
                          ? '${mission.slotsFree} libres sur ${mission.slotsTotal}'
                          : '${mission.slotsFree} libre sur ${mission.slotsTotal}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const AppBanner(
                title: 'Paiement garanti',
                message:
                    '· l’argent est déjà bloqué. Adresse exacte visible une fois retenu.',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${mission.description} Candidatures jusqu’au '
                '${formatShortDay(mission.applyDeadline)} ${formatHour(mission.applyDeadline)}.',
                style: AppTypography.body.copyWith(color: AppColors.toggleText),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppListTile(
                leading: AppAvatar(name: poster.displayName, size: 44),
                title: poster.displayName,
                subtitle:
                    '${poster.verified ? '✓ Identité vérifiée · ' : ''}'
                    '★ ${formatRating(poster.rating)} annonceur · valide en '
                    '${poster.avgValidationHours} h en moyenne',
                onTap: () => context.push(WorkerPaths.poster(poster.id)),
              ),
              if (mission.publicQuestionsCount > 0) ...[
                const SizedBox(height: AppSpacing.xs),
                TextButton(
                  onPressed: () =>
                      showComingSoon(context, 'Questions publiques'),
                  child: Text(
                    mission.publicQuestionsCount > 1
                        ? '${mission.publicQuestionsCount} questions publiques'
                        : '1 question publique',
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: AppRadius.fieldAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption),
          Text(
            value,
            style: AppTypography.label.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplyBar extends StatelessWidget {
  const _ApplyBar({required this.mission});

  final Mission mission;

  @override
  Widget build(BuildContext context) {
    final full = mission.slotsFree <= 0;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            14,
            AppSpacing.screen,
            14,
          ),
          child: AppButton(
            label: mission.alreadyApplied
                ? 'Déjà candidat'
                : full
                ? 'Complet'
                : 'Postuler',
            onPressed: mission.alreadyApplied || full
                ? null
                : () => context.push(WorkerPaths.apply(mission.id)),
          ),
        ),
      ),
    );
  }
}
