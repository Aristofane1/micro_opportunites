import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

/// Ouvre la fenêtre « Ajouter un complément » par-dessus l'écran actuel.
Future<void> showComplementSheet(
  BuildContext context, {
  required String missionId,
  required Candidate candidate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true, // la fenêtre monte avec le clavier
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => ComplementSheet(missionId: missionId, candidate: candidate),
  );
}

class ComplementSheet extends ConsumerStatefulWidget {
  const ComplementSheet({
    super.key,
    required this.missionId,
    required this.candidate,
  });

  final String missionId;
  final Candidate candidate;

  @override
  ConsumerState<ComplementSheet> createState() => _ComplementSheetState();
}

class _ComplementSheetState extends ConsumerState<ComplementSheet> {
  static const _presets = [1000, 2500];

  int? _preset = 2500; // null = « Autre »
  final _otherCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();

  @override
  void dispose() {
    _otherCtrl.dispose();
    _reasonCtrl.dispose();
    super.dispose();
  }

  int get _amount =>
      _preset ??
      (int.tryParse(_otherCtrl.text.replaceAll(RegExp(r'\D'), '')) ?? 0);

  bool get _valid => _amount > 0 && _reasonCtrl.text.trim().isNotEmpty;

  void _submit() {
    final amount = _amount;
    ref
        .read(candidatesControllerProvider.notifier)
        .proposeBonus(
          widget.missionId,
          widget.candidate.id,
          amount,
          _reasonCtrl.text.trim(),
        );
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Complément de ${formatFcfa(amount)} proposé à '
          '${widget.candidate.firstName} (simulation).',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      // laisse la place au clavier
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ajouter un complément',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pour ${widget.candidate.name} · heures en plus, pourboire…',
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 16),

            // --- Montants ---
            Row(
              children: [
                for (final p in _presets) ...[
                  Expanded(
                    child: _AmountChoice(
                      label: '+ ${groupThousands(p)}',
                      selected: _preset == p,
                      onTap: () => setState(() => _preset = p),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: _AmountChoice(
                    label: 'Autre',
                    selected: _preset == null,
                    onTap: () => setState(() => _preset = null),
                  ),
                ),
              ],
            ),
            if (_preset == null) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _otherCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsInputFormatter()],
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Montant',
                  suffixText: 'FCFA',
                ),
              ),
            ],
            const SizedBox(height: 16),

            // --- Raison ---
            const Text('Raison', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonCtrl,
              onChanged: (_) => setState(() {}),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ex. 1 heure de plus pour finir',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.candidate.firstName} doit accepter le complément. '
              'Vous le payez maintenant ; il est versé avec le reste à la '
              'validation.',
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _valid ? _submit : null,
                child: Text(
                  _amount > 0
                      ? 'Proposer et payer ${formatFcfa(_amount)}'
                      : 'Proposer et payer',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountChoice extends StatelessWidget {
  const _AmountChoice({
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? colors.primaryContainer : null,
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? colors.primary : colors.onSurface,
          ),
        ),
      ),
    );
  }
}
