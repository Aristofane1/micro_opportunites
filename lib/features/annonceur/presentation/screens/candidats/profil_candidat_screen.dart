import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
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

  void _retain(BuildContext context, WidgetRef ref, Candidate c) {
    final messenger = ScaffoldMessenger.of(context);
    final ok = ref
        .read(candidatesControllerProvider.notifier)
        .retain(missionId, c.id);
    if (!ok) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Toutes les places sont déjà prises.')),
      );
      return;
    }
    context.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text('${c.firstName} est retenu(e) : 12 h pour confirmer.'),
      ),
    );
  }

  void _refuse(BuildContext context, WidgetRef ref, Candidate c) {
    ref.read(candidatesControllerProvider.notifier).refuse(missionId, c.id);
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final mission = ref
        .watch(missionsWithCountsProvider)
        .where((m) => m.id == missionId)
        .firstOrNull;
    final c = ref.watch(
      candidatesControllerProvider.select(
        (m) => (m[missionId] ?? const <Candidate>[])
            .where((x) => x.id == candidateId)
            .firstOrNull,
      ),
    );

    if (c == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Candidat introuvable.')),
      );
    }

    return Scaffold(
      body: SafeArea(
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
                                  if (c.isExpert)
                                    const _Tag(
                                      'Expert',
                                      bg: AppColors.ink,
                                      fg: AppColors.ochre,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${c.city} · membre depuis ${c.memberSince}',
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

                    // --- Missions réalisées ---
                    const Text(
                      'Missions réalisées',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (c.doneMissions.isEmpty)
                      Text(
                        'Aucune mission réalisée pour le moment.',
                        style: TextStyle(color: colors.onSurfaceVariant),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final d in c.doneMissions)
                            _DoneChip(
                              // en couleur quand c'est la même catégorie que la mission
                              highlighted: d.category == mission?.category,
                              label:
                                  '${d.category.label} × ${d.count}'
                                  '${d.category == mission?.category ? ' · confirmée' : ''}',
                            ),
                        ],
                      ),
                    const SizedBox(height: 20),

                    // --- Compétences ---
                    const Text(
                      'Compétences déclarées',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(c.skills),
                    const SizedBox(height: 20),

                    // --- Dernier avis ---
                    if (c.review != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.outlineVariant),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  c.review!.author,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '★' * c.review!.stars,
                                  style: TextStyle(color: colors.primary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(c.review!.text),
                            const SizedBox(height: 8),
                            Text(
                              'Ponctualité ${c.review!.punctuality} · '
                              'Qualité ${c.review!.quality} · '
                              'Communication ${c.review!.communication}',
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _DoneChip extends StatelessWidget {
  const _DoneChip({required this.label, required this.highlighted});
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.softGreen : colors.surface,
        border: highlighted ? null : Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: highlighted ? AppColors.green : colors.onSurface,
        ),
      ),
    );
  }
}
