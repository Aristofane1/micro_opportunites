import 'package:flutter/material.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';

class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});

  final MissionStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // (couleur de fond, couleur du texte)
    final (bg, fg) = switch (status) {
      MissionStatus.published => (
        const Color(0xFFDDEEE6),
        const Color(0xFF1F6B4F),
      ),
      MissionStatus.inProgress => (
        const Color(0xFFE3ECF6),
        const Color(0xFF2F5D8A),
      ),
      MissionStatus.selected => (
        const Color(0xFFFBEBD3),
        const Color(0xFF9A5B0C),
      ),
      MissionStatus.cancelled => (const Color(0xFFF8E1DE), colors.error),
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
