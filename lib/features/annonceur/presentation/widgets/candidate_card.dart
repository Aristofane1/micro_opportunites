import 'package:flutter/material.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

const _green = AppColors.green;

/// Cercle avec les initiales (« SO »).
class CandidateAvatar extends StatelessWidget {
  const CandidateAvatar(
    this.candidate, {
    super.key,
    this.size = 52,
    this.serif = false,
  });

  final Candidate candidate;
  final double size;
  final bool serif; // police à empattements (profil)

  @override
  Widget build(BuildContext context) {
    final isNew = candidate.isNew;
    final bg = isNew ? AppColors.pendingBackground : AppColors.softGreen;
    final fg = isNew ? AppColors.ochreDeep : _green;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Text(
        candidate.initials,
        style: TextStyle(
          fontFamily: serif ? 'Lora' : null,
          fontSize: size * 0.33,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

/// Carte d'un candidat dans la liste (C09).
class CandidateCard extends StatelessWidget {
  const CandidateCard({
    super.key,
    required this.candidate,
    required this.onTap,
    this.onRefuse,
    this.onRetain,
    this.statusLabel,
    this.busy = false,
  });

  final Candidate candidate;
  final VoidCallback onTap;
  final VoidCallback?
  onRefuse; // boutons affichés seulement si onRetain != null
  final VoidCallback? onRetain;
  final String? statusLabel; // texte affiché à la place des boutons
  final bool busy; // action en cours : boutons désactivés

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final c = candidate;
    final rating = c.rating == null ? '' : '★ ${formatRating(c.rating!)} · ';
    final subtitle = c.isNew
        ? 'Nouveau · aucun avis encore'
        : '$rating${c.missionsCount} missions · fiabilité ${c.reliability ?? '–'} %';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CandidateAvatar(c),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                c.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (c.verified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.check, size: 14, color: _green),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (c.isExpert)
                    const _Badge(
                      'Expert',
                      bg: AppColors.ink,
                      fg: AppColors.ochre,
                    )
                  else if (c.isNew)
                    _Badge(
                      'Nouveau',
                      bg: colors.surfaceContainerHigh,
                      fg: colors.onSurfaceVariant,
                    ),
                ],
              ),
              if (c.pitch.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('« ${c.pitch} »'),
              ],
              const SizedBox(height: 14),
              if (onRetain != null)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: busy ? null : onRefuse,
                        child: const Text('Refuser'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: _green,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: busy ? null : onRetain,
                        child: const Text('Retenir'),
                      ),
                    ),
                  ],
                )
              else if (statusLabel != null)
                Text(
                  statusLabel!,
                  style: const TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label, {required this.bg, required this.fg});
  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700),
    ),
  );
}
