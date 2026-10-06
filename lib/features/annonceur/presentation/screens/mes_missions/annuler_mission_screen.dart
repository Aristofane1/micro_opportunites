import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/payments_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

const _red = Color(0xFFB42318);

class AnnulerMissionScreen extends ConsumerStatefulWidget {
  const AnnulerMissionScreen({super.key, required this.missionId});

  final String missionId;

  @override
  ConsumerState<AnnulerMissionScreen> createState() =>
      _AnnulerMissionScreenState();
}

class _AnnulerMissionScreenState extends ConsumerState<AnnulerMissionScreen> {
  static const _reasons = [
    'Événement reporté',
    'Plus besoin de ce service',
    'Erreur dans la mission',
    'Autre raison',
  ];

  String _reason = _reasons.first;

  void _confirm(MissionSummary mission) {
    final messenger = ScaffoldMessenger.of(context);

    // SIMULATION : on rembourse l'argent encore bloqué. Les indemnités et les
    // frais n'étant pas fixés, ils ne sont pas déduits ici.
    ref
        .read(paymentsControllerProvider.notifier)
        .addRefund(
          missionTitle: mission.title,
          amount: mission.blockedNow,
          reason: 'Remboursé · mission annulée',
        );
    ref.read(myMissionsControllerProvider.notifier).cancel(mission.id);

    context.go(AppRoutes.posterMissions);
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Mission annulée. Le reste vous sera remboursé sous 48 h (simulation).',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mission = ref
        .watch(missionsWithCountsProvider)
        .where((m) => m.id == widget.missionId)
        .firstOrNull;

    if (mission == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Mission introuvable.')),
      );
    }

    final confirmed = mission.slotsConfirmed;

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
                    Row(
                      children: [
                        IconButton.outlined(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Annuler la mission',
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- Alerte : des personnes comptent sur la mission ---
                    if (confirmed > 0)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDEAE7),
                          border: Border.all(color: _red),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(color: Color(0xFF7A1F16)),
                            children: [
                              TextSpan(
                                text: confirmed == 1
                                    ? '1 personne a confirmé'
                                    : '$confirmed personnes ont confirmé',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: confirmed == 1
                                    ? ' et compte sur cette mission. Une indemnité lui sera versée.'
                                    : ' et comptent sur cette mission. Une indemnité leur sera versée.',
                              ),
                            ],
                          ),
                        ),
                      ),

                    // --- Ce qui se passe ---
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        border: Border.all(color: colors.outlineVariant),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ce qui se passe',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 12),
                          _Line(
                            'Argent bloqué',
                            formatFcfa(mission.blockedNow),
                          ),
                          if (confirmed > 0) ...[
                            const SizedBox(height: 8),
                            _Line(
                              'Indemnités ($confirmed personne${confirmed > 1 ? 's' : ''})',
                              '− [taux à fixer]',
                            ),
                          ],
                          const SizedBox(height: 8),
                          const _Line('Frais de transaction', 'non remboursés'),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Vous récupérerez',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                'le reste, sous 48 h',
                                style: TextStyle(
                                  fontFamily: 'Lora',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Plus de 24 h avant la mission : indemnité réduite. '
                            'Moins de 24 h : indemnité pleine.',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // --- Motif ---
                    const Text(
                      'Motif (envoyé aux candidats)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _reason,
                      items: [
                        for (final r in _reasons)
                          DropdownMenuItem(value: r, child: Text(r)),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _reason = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Les annulations tardives répétées baissent votre score '
                      'd\'annonceur fiable.',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Actions ---
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(top: BorderSide(color: colors.outlineVariant)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: _red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _confirm(mission),
                      child: const Text('Confirmer l\'annulation'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Garder la mission'),
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

// Une ligne « libellé ........ valeur »
class _Line extends StatelessWidget {
  const _Line(this.left, this.right);
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(left, style: TextStyle(color: muted)),
        ),
        const SizedBox(width: 8),
        Text(right),
      ],
    );
  }
}
