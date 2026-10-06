import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/candidate_card.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class ProfilCandidatScreen extends ConsumerWidget {
  const ProfilCandidatScreen({
    super.key,
    required this.missionId,
    required this.candidateId,
  });

  final String missionId;
  final String candidateId;

  static const _green = AppColors.green;

  Future<void> _retain(BuildContext context, WidgetRef ref, Candidate c) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(annonceurActionsProvider.notifier)
        .retain(c.id);
    if (!context.mounted) return;
    switch (result) {
      case Success():
        context.pop();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              '${c.firstName} est retenu(e) : 12 h pour confirmer.',
            ),
          ),
        );
      case Err(:final failure):
        messenger.showSnackBar(SnackBar(content: Text(failure.message)));
    }
  }

  Future<void> _refuse(BuildContext context, WidgetRef ref, Candidate c) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(annonceurActionsProvider.notifier)
        .reject(c.id);
    if (!context.mounted) return;
    switch (result) {
      case Success():
        context.pop();
      case Err(:final failure):
        messenger.showSnackBar(SnackBar(content: Text(failure.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = missionCandidatesProvider(missionId);
    return Scaffold(
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        data: (all) {
          final c = all.where((x) => x.id == candidateId).firstOrNull;
          if (c == null) {
            return const Center(child: Text('Candidat introuvable.'));
          }
          return _buildProfile(context, ref, c);
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, WidgetRef ref, Candidate c) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton.outlined(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: 16),

                  // --- Identité ---
                  Row(
                    children: [
                      CandidateAvatar(c, size: 84, serif: true),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              style: const TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              children: [
                                if (c.verified)
                                  const _Tag(
                                    'Vérifiée',
                                    icon: Icons.check,
                                    bg: AppColors.softGreen,
                                    fg: _green,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${c.city} · membre depuis ${formatMonthYear(c.memberSince)}',
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Chiffres clés ---
                  Row(
                    children: [
                      Expanded(
                        child: _Stat(
                          value: c.rating == null
                              ? '–'
                              : formatRating(c.rating!),
                          label: c.reviewsCount == 0
                              ? 'aucun avis'
                              : 'note · ${c.reviewsCount} avis',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _Stat(
                          value: c.reliability == null
                              ? '–'
                              : '${c.reliability} %',
                          label: 'fiabilité',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _Stat(
                          value: '${c.absences}',
                          label: c.absences > 1 ? 'absences' : 'absence',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Compétences ---
                  const Text(
                    'Compétences déclarées',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(c.skills),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // --- Actions (seulement tant que la candidature est en attente) ---
          if (c.status == CandidateStatus.pending)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(top: BorderSide(color: colors.outlineVariant)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () => _refuse(context, ref, c),
                        child: const Text('Refuser'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 52,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: _green,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: () => _retain(context, ref, c),
                        child: Text('Retenir ${c.firstName}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, {required this.bg, required this.fg, this.icon});
  final String label;
  final Color bg;
  final Color fg;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 2),
        ],
        Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Lora',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
