import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/candidate_card.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class SuiviDuJourScreen extends ConsumerWidget {
  const SuiviDuJourScreen({super.key, required this.missionId});

  final String missionId;

  static const _green = AppColors.green;
  static const _blue = AppColors.blue;

  String _hour(DateTime? d) => d == null ? '–' : formatHour(d);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionProvider = posterMissionProvider(missionId);
    final candidatesProvider = missionCandidatesProvider(missionId);
    return Scaffold(
      body: AsyncValueView(
        value: ref.watch(missionProvider),
        onRetry: () => ref.invalidate(missionProvider),
        data: (mission) => AsyncValueView(
          value: ref.watch(candidatesProvider),
          onRetry: () => ref.invalidate(candidatesProvider),
          data: (all) => _buildDay(
            context,
            mission,
            all.where((c) => c.status == CandidateStatus.confirmed).toList(),
            ref.watch(clockProvider)(),
          ),
        ),
      ),
    );
  }

  Widget _buildDay(
    BuildContext context,
    MissionSummary mission,
    List<Candidate> workers,
    DateTime now,
  ) {
    final colors = Theme.of(context).colorScheme;
    final arrived = workers
        .where(
          (c) => const {
            AttendanceStatus.arrived,
            AttendanceStatus.finished,
            AttendanceStatus.validated,
            AttendanceStatus.contested,
          }.contains(c.attendance),
        )
        .length;
    final dayLabel = formatDayRelative(mission.startAt, now);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- En-tête ---
            Row(
              children: [
                IconButton.outlined(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$dayLabel · ${formatHour(mission.startAt)} – ${formatHour(mission.endAt)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const Text(
                      'Suivi du jour',
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Bandeau « x / y arrivés » ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mission en cours',
                    style: TextStyle(color: AppColors.white),
                  ),
                  Text(
                    '$arrived / ${workers.length} arrivés',
                    style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Liste des personnes ---
            if (workers.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('Personne n\'est encore confirmé.')),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border.all(color: colors.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    for (var i = 0; i < workers.length; i++) ...[
                      if (i > 0) const Divider(height: 1),
                      _buildRow(context, workers[i], colors),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Une ligne de la liste : avatar, nom, sous-titre coloré, état à droite
  Widget _buildRow(BuildContext context, Candidate c, ColorScheme colors) {
    final (subtitle, subtitleColor) = switch (c.attendance) {
      AttendanceStatus.finished => (
        'Arrivé ${_hour(c.arrivedAt)}'
            '${c.distanceMeters == null ? '' : ' · à ${c.distanceMeters} m'}',
        _green,
      ),
      AttendanceStatus.arrived => ('Arrivé ${_hour(c.arrivedAt)}', _green),
      AttendanceStatus.validated => ('Travail validé · payé', _green),
      AttendanceStatus.contested => ('Travail contesté', colors.error),
      AttendanceStatus.notArrived => (
        'Pas encore arrivé',
        colors.onSurfaceVariant,
      ),
    };

    final trailing = switch (c.attendance) {
      AttendanceStatus.finished => const _StatePill(
        'À valider',
        bg: _blue,
        fg: AppColors.white,
      ),
      AttendanceStatus.arrived => const _StatePill(
        'En cours',
        bg: AppColors.softBlue,
        fg: _blue,
      ),
      AttendanceStatus.validated => const _StatePill(
        'Payé',
        bg: AppColors.softGreen,
        fg: _green,
      ),
      AttendanceStatus.contested => _StatePill(
        'Contesté',
        bg: AppColors.softRed,
        fg: colors.error,
      ),
      _ => null,
    };

    return InkWell(
      // seul le travail terminé ouvre l'écran de validation
      onTap: c.attendance == AttendanceStatus.finished
          ? () => context.push(PosterPaths.validate(missionId, c.assignmentId!))
          : null,
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CandidateAvatar(c, size: 44),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.5, color: subtitleColor),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing],
          ],
        ),
      ),
    );
  }
}

class _StatePill extends StatelessWidget {
  const _StatePill(this.label, {required this.bg, required this.fg});
  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w700),
    ),
  );
}
