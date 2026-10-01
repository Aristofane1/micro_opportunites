import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';

/// Carte d'une candidature dans « Mes candidatures » (B08).
class ApplicationCard extends StatelessWidget {
  const ApplicationCard({
    super.key,
    required this.application,
    required this.now,
    this.onTap,
    this.onWithdraw,
  });

  final Application application;
  final DateTime now;
  final VoidCallback? onTap;
  final VoidCallback? onWithdraw;

  String _remaining(DateTime expiresAt) {
    final left = expiresAt.difference(now);
    if (left.isNegative) return 'expirée';
    if (left.inHours >= 1) return 'reste ${left.inHours} h';
    return 'reste ${left.inMinutes < 1 ? 1 : left.inMinutes} min';
  }

  @override
  Widget build(BuildContext context) {
    final mission = application.mission;
    final status = application.status;
    final (Widget badge, Widget? trailing) = switch (status) {
      ApplicationStatus.offered => (
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: const BoxDecoration(
            color: AppColors.ochreDeep,
            borderRadius: AppRadius.pillAll,
          ),
          child: Text(
            'Retenu · à confirmer',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.small.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          _remaining(application.offerExpiresAt ?? now),
          style: AppTypography.small.copyWith(
            color: AppColors.ochreDeep,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      ApplicationStatus.confirmed => (
        const StatusBadge(MissionStatusKind.confirmed),
        Text(
          '${formatShortDay(mission.startAt)} · ${formatHour(mission.startAt)}',
          style: AppTypography.caption,
        ),
      ),
      ApplicationStatus.pending => (
        const StatusBadge(MissionStatusKind.pending),
        onWithdraw == null
            ? null
            : TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.ochreDeep,
                ),
                onPressed: onWithdraw,
                child: const Text('Retirer'),
              ),
      ),
      ApplicationStatus.pendingSync => (
        const StatusBadge(MissionStatusKind.pendingSync),
        const Text('hors-ligne', style: AppTypography.caption),
      ),
      ApplicationStatus.declined => (
        const StatusBadge(MissionStatusKind.cancelled, label: 'Déclinée'),
        null,
      ),
      ApplicationStatus.withdrawn => (
        const StatusBadge(MissionStatusKind.cancelled, label: 'Retirée'),
        null,
      ),
      ApplicationStatus.rejected => (
        const StatusBadge(MissionStatusKind.cancelled, label: 'Non retenue'),
        null,
      ),
      ApplicationStatus.expired => (
        const StatusBadge(MissionStatusKind.expired),
        null,
      ),
    };
    final subtitle = switch (status) {
      ApplicationStatus.confirmed =>
        '${mission.city} · adresse et itinéraire disponibles',
      ApplicationStatus.offered =>
        '${mission.city} · ${formatDayRelative(mission.startAt, now)} '
            '${formatHour(mission.startAt)} · ${formatFcfa(mission.payAmount)}',
      _ =>
        '${mission.city} · ${formatShortDay(mission.startAt)} · '
            '${formatFcfa(mission.payAmount)}',
    };
    final (background, border, borderWidth) = switch (status) {
      ApplicationStatus.offered => (AppColors.card, AppColors.ochreDeep, 2.0),
      ApplicationStatus.pendingSync => (
        AppColors.syncBackground,
        AppColors.syncBorder,
        1.0,
      ),
      _ => (AppColors.card, AppColors.line, 1.0),
    };

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardAll,
        side: BorderSide(color: border, width: borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(alignment: Alignment.centerLeft, child: badge),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  ?trailing,
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                mission.title,
                style: AppTypography.bodyStrong.copyWith(
                  fontSize: 16,
                  fontWeight: status == ApplicationStatus.pendingSync
                      ? FontWeight.w600
                      : FontWeight.w700,
                  color: status == ApplicationStatus.pendingSync
                      ? AppColors.toggleText
                      : AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTypography.caption),
            ],
          ),
        ),
      ),
    );
  }
}
