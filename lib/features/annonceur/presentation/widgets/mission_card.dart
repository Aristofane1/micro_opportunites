import 'package:flutter/material.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/status_chip.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({super.key, required this.mission, required this.onTap});

  final MissionSummary mission;
  final VoidCallback onTap;

  static const _green = AppColors.green;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final m = mission;
    // Le montant bloqué n'apparaît que quand quelqu'un est retenu (comme la maquette)
    final showBlocked =
        m.blockedAmount > 0 &&
        (m.status == MissionStatus.inProgress ||
            m.status == MissionStatus.selected);

    return Material(
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusChip(m.status),
                  Text(
                    '${formatDay(m.startAt)} · ${formatHour(m.startAt)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                m.title,
                style: const TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 4,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${m.slotsConfirmed}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text:
                              '/${m.slotsTotal} '
                              '${m.slotsTotal > 1 ? 'confirmés' : 'confirmé'}',
                        ),
                      ],
                    ),
                  ),
                  if (m.newApplicantsCount > 0)
                    Text(
                      '${m.newApplicantsCount} '
                      '${m.newApplicantsCount > 1 ? 'nouveaux candidats' : 'nouveau candidat'}',
                      style: const TextStyle(
                        color: _green,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  else
                    Text(
                      '${m.applicantsCount} '
                      'candidat${m.applicantsCount > 1 ? 's' : ''}',
                    ),
                  if (showBlocked)
                    Text(
                      '${groupThousands(m.blockedAmount)} bloqués',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
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
