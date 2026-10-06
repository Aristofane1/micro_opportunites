import 'package:flutter/material.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});

  final MissionStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // (couleur de fond, couleur du texte)
    final (bg, fg) = switch (status) {
      MissionStatus.published => (AppColors.softGreen, AppColors.green),
      MissionStatus.inProgress => (AppColors.softBlue, AppColors.blue),
      MissionStatus.selected => (
        AppColors.pendingBackground,
        AppColors.ochreDeep,
      ),
      MissionStatus.cancelled => (AppColors.softRed, colors.error),
      _ => (colors.surfaceContainerHigh, colors.onSurfaceVariant),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}
