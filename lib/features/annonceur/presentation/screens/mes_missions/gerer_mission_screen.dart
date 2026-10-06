import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/status_chip.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class GererMissionScreen extends ConsumerWidget {
  const GererMissionScreen({super.key, required this.missionId});

  final String missionId;

  static const _green = AppColors.green;

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Bientôt disponible')));
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Annuler la mission ?'),
        content: const Text(
          'La mission ne sera plus visible par les exécutants.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    // On récupère le contrôleur AVANT de quitter l'écran (ref n'est plus
    // utilisable une fois l'écran fermé), puis on retire la mission.
    final missions = ref.read(myMissionsControllerProvider.notifier);
    context.go(PosterPaths.missions);
    missions.remove(missionId);
  }

  String _count(int n, String word) => '$n $word${n > 1 ? 's' : ''}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missions = ref.watch(missionsWithCountsProvider);
    final mission = missions.where((m) => m.id == missionId).firstOrNull;
    final colors = Theme.of(context).colorScheme;

    if (mission == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Mission introuvable.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go(PosterPaths.missions),
                child: const Text('Retour'),
              ),
            ],
          ),
        ),
      );
    }

    final start = mission.startAt;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- En-tête : retour + statut ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.outlined(
                    onPressed: () => context.canPop()
                        ? context.pop()
                        : context.go(PosterPaths.missions),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  StatusChip(mission.status),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                mission.title,
                style: const TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${formatDay(start)} · ${formatHour(start)} · '
                '${mission.city} · ${mission.payLabel}',
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),

              // --- Carte des places ---
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
                        const Text(
                          'Places',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Flexible(
                          child: Text(
                            '${_count(mission.slotsConfirmed, 'confirmée')} · '
                            '${_count(mission.slotsOffered, 'offerte')} · '
                            '${_count(mission.slotsFree, 'libre')}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 13,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var i = 0; i < mission.slotsTotal; i++)
                          if (i < mission.slotsConfirmed)
                            const _FilledSlot()
                          else
                            _DashedSlot(
                              // place offerte en couleur principale, libre en gris
                              color:
                                  i <
                                      mission.slotsConfirmed +
                                          mission.slotsOffered
                                  ? colors.primary
                                  : colors.outline,
                            ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Argent bloqué',
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                        Text(
                          formatFcfa(mission.blockedAmount),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // --- Menu ---
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _MenuRow(
                      title: 'Candidats',
                      badge: mission.newApplicantsCount > 0
                          ? '${mission.newApplicantsCount} '
                                '${mission.newApplicantsCount > 1 ? 'nouveaux' : 'nouveau'}'
                          : null,
                      onTap: () =>
                          context.push(PosterPaths.candidates(mission.id)),
                    ),
                    const Divider(height: 1),
                    _MenuRow(
                      title: 'Suivi du jour',
                      onTap: () => context.push(PosterPaths.today(mission.id)),
                    ),
                    const Divider(height: 1),
                    _MenuRow(
                      title: 'Questions publiques',
                      count: '0',
                      onTap: () => _soon(context),
                    ),
                    const Divider(height: 1),
                    _MenuRow(
                      title: 'Modifier',
                      subtitle:
                          'Montant, date et lieu figés depuis la 1re confirmation',
                      onTap: () => _soon(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.error,
                  ),
                  onPressed: () => _confirmCancel(context, ref),
                  child: const Text('Annuler la mission'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Une ligne du menu (titre, pastille ou compteur optionnels, flèche)
class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.count,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final String? count;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: GererMissionScreen._green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: const TextStyle(fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count != null) Text(count!),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

// Une place confirmée : cercle plein
class _FilledSlot extends StatelessWidget {
  const _FilledSlot();

  @override
  Widget build(BuildContext context) => Container(
    width: 52,
    height: 52,
    decoration: const BoxDecoration(
      color: GererMissionScreen._green,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.person, color: AppColors.white),
  );
}

// Une place offerte ou libre : cercle en pointillés
class _DashedSlot extends StatelessWidget {
  const _DashedSlot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size(52, 52),
    painter: _DashedCirclePainter(color),
  );
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 - 1,
    );
    const dashes = 24;
    const sweep = 2 * math.pi / dashes;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, i * sweep, sweep * 0.55, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter old) => old.color != color;
}
