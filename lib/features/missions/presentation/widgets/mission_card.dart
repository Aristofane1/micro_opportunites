import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';

/// Carte mission de la planche Z3 / B01.
class MissionCard extends StatelessWidget {
  const MissionCard({
    super.key,
    required this.mission,
    required this.now,
    required this.onTap,
  });

  final Mission mission;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final places = mission.slotsFree > 1
        ? '${mission.slotsFree} places'
        : '${mission.slotsFree} place';
    return Material(
      color: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.cardAll,
        side: BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      mission.category.label.toUpperCase(),
                      style: AppTypography.small.copyWith(
                        color: AppColors.ochreDeep,
                      ),
                    ),
                  ),
                  Text(
                    formatRelativePast(mission.publishedAt, now),
                    style: AppTypography.small.copyWith(
                      color: AppColors.inkSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(mission.title, style: AppTypography.subtitle),
              const SizedBox(height: 6),
              Text(
                '${mission.city} · ${formatDayRelative(mission.startAt, now)} · '
                '${formatDuration(mission.duration)}',
                style: AppTypography.caption,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatFcfa(mission.payAmount),
                      style: AppTypography.amount.copyWith(fontSize: 20),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.softGreen,
                        borderRadius: AppRadius.pillAll,
                      ),
                      child: Text(
                        'Garanti · $places',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.small.copyWith(
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
