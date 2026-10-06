import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_method.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

class EtapePayerScreen extends ConsumerWidget {
  const EtapePayerScreen({super.key});

  // « 5 000 FCFA × 5 personnes » (ou avec la durée si c'est payé à l'heure)
  String _calcLabel(MissionDraft d) {
    final unit = formatFcfa(d.payAmount ?? 0);
    final people = '${d.slotsTotal} personne${d.slotsTotal > 1 ? 's' : ''}';
    return switch (d.payUnit) {
      PayUnit.hourly =>
        '$unit × ${formatDuration(d.durationMinutes)} × $people',
      _ => '$unit × $people',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(missionDraftControllerProvider);
    final controller = ref.read(missionDraftControllerProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final start = draft.startAt;
    final when = start == null
        ? ''
        : '${formatDay(start)} · ${formatHour(start)} · ';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bloquer le paiement',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          // --- Récapitulatif ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: colors.outlineVariant),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  draft.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '$when${draft.city ?? ''}',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                _Line(_calcLabel(draft), formatFcfa(draft.totalToBlock)),
                const SizedBox(height: 6),
                _Line('Frais de service', '[à définir]', muted: true),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: groupThousands(draft.totalToBlock),
                            style: const TextStyle(
                              fontFamily: 'Lora',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: ' + frais',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Moyens de paiement ---
          const Text(
            'Payer avec',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          for (final method in PaymentMethod.values) ...[
            _MethodTile(
              label: method.label,
              selected: draft.paymentMethod == method,
              onTap: () => controller.updatePaymentMethod(method),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),

          // --- Rassurance ---
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text.rich(
              TextSpan(
                children: const [
                  TextSpan(text: 'L\'argent reste '),
                  TextSpan(
                    text: 'bloqué',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        ' jusqu\'à votre validation. Personne retenu à la date ? ',
                  ),
                  TextSpan(
                    text: 'Remboursement automatique.',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              style: TextStyle(color: colors.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

// Une ligne « libellé ........ valeur »
class _Line extends StatelessWidget {
  const _Line(this.left, this.right, {this.muted = false});
  final String left;
  final String right;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final color = muted ? Theme.of(context).colorScheme.onSurfaceVariant : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(left, style: TextStyle(color: color)),
        ),
        const SizedBox(width: 8),
        Text(right, style: TextStyle(color: color)),
      ],
    );
  }
}

// Un moyen de paiement (sélectionné = bordure épaisse)
class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
