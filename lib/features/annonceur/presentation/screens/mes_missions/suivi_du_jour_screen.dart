import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/candidate_card.dart';

class SuiviDuJourScreen extends ConsumerWidget {
  const SuiviDuJourScreen({super.key, required this.missionId});

  final String missionId;

  static const _green = Color(0xFF1F6B4F);
  static const _blue = Color(0xFF2F5D8A);
  static const _amber = Color(0xFF9A5B0C);

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Bientôt disponible')));
  }

  String _hour(DateTime? d) => d == null ? '–' : formatHour(d);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final mission = ref
        .watch(missionsWithCountsProvider)
        .where((m) => m.id == missionId)
        .firstOrNull;
    final workers = ref
        .watch(
          candidatesControllerProvider.select(
            (m) => m[missionId] ?? const <Candidate>[],
          ),
        )
        .where((c) => c.status == CandidateStatus.confirmed)
        .toList();

    if (mission == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Mission introuvable.')),
      );
    }

    final arrived = workers
        .where(
          (c) => const {
            AttendanceStatus.arrived,
            AttendanceStatus.unconfirmed,
            AttendanceStatus.finished,
            AttendanceStatus.validated,
          }.contains(c.attendance),
        )
        .length;
    final absents = workers
        .where((c) => c.attendance == AttendanceStatus.absent)
        .toList();
    final dayLabel = DateUtils.isSameDay(mission.startAt, DateTime.now())
        ? 'Aujourd\'hui'
        : formatDay(mission.startAt);

    return Scaffold(
      body: SafeArea(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: _blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mission en cours',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '$arrived / ${workers.length} arrivés',
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
                  child: Center(
                    child: Text('Personne n\'est encore confirmé.'),
                  ),
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
                        _buildRow(context, ref, workers[i], colors),
                      ],
                    ],
                  ),
                ),

              // --- Une carte par absent ---
              for (final c in absents) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border.all(color: colors.error),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${c.name} est absent(e). ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(text: 'Que faire de sa place ?'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _soon(context),
                              child: const Text('Me rembourser'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: _green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => _soon(context),
                              child: const Text('Trouver un remplaçant'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Une ligne de la liste : avatar, nom, sous-titre coloré, état à droite
  Widget _buildRow(
    BuildContext context,
    WidgetRef ref,
    Candidate c,
    ColorScheme colors,
  ) {
    final (subtitle, subtitleColor) = switch (c.attendance) {
      AttendanceStatus.finished => (
        'Arrivé ${_hour(c.arrivedAt)}'
            '${c.distanceMeters == null ? '' : ' · à ${c.distanceMeters} m'}',
        _green,
      ),
      AttendanceStatus.arrived => ('Arrivé ${_hour(c.arrivedAt)}', _green),
      AttendanceStatus.validated => ('Travail validé · payé', _green),
      AttendanceStatus.unconfirmed => (
        'GPS faible · confirmez-vous sa présence ?',
        _amber,
      ),
      AttendanceStatus.absent => (
        'Pas de check-in · ${_hour(c.noCheckInAt)}',
        colors.error,
      ),
      AttendanceStatus.notArrived => (
        'Pas encore arrivé',
        colors.onSurfaceVariant,
      ),
    };

    final trailing = switch (c.attendance) {
      AttendanceStatus.finished => const _StatePill(
        'À valider',
        bg: _blue,
        fg: Colors.white,
      ),
      AttendanceStatus.arrived => const _StatePill(
        'En cours',
        bg: Color(0xFFE3ECF6),
        fg: _blue,
      ),
      AttendanceStatus.validated => const _StatePill(
        'Payé',
        bg: Color(0xFFDDEEE6),
        fg: _green,
      ),
      AttendanceStatus.unconfirmed => OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: _green,
          side: const BorderSide(color: _green),
          visualDensity: VisualDensity.compact,
        ),
        onPressed: () => ref
            .read(candidatesControllerProvider.notifier)
            .confirmPresence(missionId, c.id),
        child: const Text('Oui, présent(e)'),
      ),
      _ => null,
    };

    final absent = c.attendance == AttendanceStatus.absent;

    return InkWell(
      // seul le travail terminé ouvre l'écran de validation
      onTap: c.attendance == AttendanceStatus.finished
          ? () => context.push(AppRoutes.posterValidate(missionId, c.id))
          : null,
      child: Container(
        color: absent ? const Color(0xFFFDEAE7) : null,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CandidateAvatar(c, size: 44, danger: absent),
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
