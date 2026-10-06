import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/thousands_input_formatter.dart';

/// « 08:00 » : heure saisie dans les sélecteurs (heure de l'appareil).
String _clock(DateTime time) =>
    '${time.hour.toString().padLeft(2, '0')}:'
    '${time.minute.toString().padLeft(2, '0')}';

class EtapeQuandCombienScreen extends ConsumerStatefulWidget {
  const EtapeQuandCombienScreen({super.key});

  @override
  ConsumerState<EtapeQuandCombienScreen> createState() =>
      _EtapeQuandCombienScreenState();
}

class _EtapeQuandCombienScreenState
    extends ConsumerState<EtapeQuandCombienScreen> {
  static const _durations = [60, 120, 180, 240, 360, 480]; // en minutes

  late final TextEditingController _amountCtrl;

  MissionDraftController get _controller =>
      ref.read(missionDraftControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    final amount = ref.read(missionDraftControllerProvider).payAmount;
    _amountCtrl = TextEditingController(
      text: amount == null ? '' : formatAmount(amount),
    );
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Future<void> _pickDate() async {
    final current = ref.read(missionDraftControllerProvider).startAt;
    final picked = await showDatePicker(
      context: context,
      initialDate: (current == null || current.isBefore(_today))
          ? _today.add(const Duration(days: 1))
          : current,
      firstDate: _today,
      lastDate: _today.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    _controller.updateDate(picked);
  }

  Future<void> _pickTime() async {
    final current = ref.read(missionDraftControllerProvider).startAt;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: current?.hour ?? 8,
        minute: current?.minute ?? 0,
      ),
    );
    if (picked == null || !mounted) return;
    _controller.updateTime(picked.hour, picked.minute);
  }

  Future<void> _pickDuration() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final minutes in _durations)
              ListTile(
                title: Text(formatDuration(Duration(minutes: minutes))),
                onTap: () => Navigator.of(sheetContext).pop(minutes),
              ),
          ],
        ),
      ),
    );
    if (picked == null || !mounted) return;
    _controller.updateDuration(picked);
  }

  Future<void> _pickDeadline() async {
    final draft = ref.read(missionDraftControllerProvider);
    final last = draft.startAt ?? _today.add(const Duration(days: 365));
    final lastDay = DateTime(last.year, last.month, last.day);
    var initial = draft.applyDeadline ?? lastDay;
    if (initial.isBefore(_today)) initial = _today;
    if (initial.isAfter(lastDay)) initial = lastDay;

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: _today,
      lastDate: lastDay,
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: draft.applyDeadline?.hour ?? 18,
        minute: draft.applyDeadline?.minute ?? 0,
      ),
    );
    if (time == null || !mounted) return;

    _controller.updateApplyDeadline(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(missionDraftControllerProvider);
    final colors = Theme.of(context).colorScheme;
    final start = draft.startAt;
    final deadline = draft.applyDeadline;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Date / Heure / Durée ---
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _PickerBox(
                  label: 'Date',
                  value: start == null ? 'Choisir' : formatShortDay(start),
                  onTap: _pickDate,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: _PickerBox(
                  label: 'Heure',
                  value: start == null ? '--:--' : _clock(start),
                  onTap: _pickTime,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: _PickerBox(
                  label: 'Durée',
                  value: formatDuration(
                    Duration(minutes: draft.durationMinutes),
                  ),
                  onTap: _pickDuration,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Rémunération ---
          const Text(
            'Rémunération par personne',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [ThousandsInputFormatter()],
            onChanged: (text) {
              final digits = text.replaceAll(RegExp(r'\D'), '');
              _controller.updatePayAmount(
                digits.isEmpty ? null : int.parse(digits),
              );
            },
            style: const TextStyle(
              fontFamily: 'Lora',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: '0',
              suffixText: 'FCFA',
            ),
          ),
          const SizedBox(height: 16),

          // --- Forfait / Par heure / Par jour ---
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<PayUnit>(
              showSelectedIcon: false,
              segments: [
                for (final unit in PayUnit.values)
                  ButtonSegment(value: unit, label: Text(unit.label)),
              ],
              selected: {draft.payUnit},
              onSelectionChanged: (selection) =>
                  _controller.updatePayUnit(selection.first),
            ),
          ),
          const SizedBox(height: 20),

          // --- Nombre de personnes ---
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de personnes',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Chacune est payée séparément',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton.outlined(
                onPressed: draft.slotsTotal > 1
                    ? _controller.decreaseSlots
                    : null,
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 44,
                child: Center(
                  child: Text(
                    '${draft.slotsTotal}',
                    style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              IconButton.outlined(
                onPressed: _controller.increaseSlots,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Date limite de candidature ---
          _PickerBox(
            label: 'Candidatures jusqu\'au',
            value: deadline == null
                ? 'Choisir'
                : '${formatShortDay(deadline)} · ${_clock(deadline)}',
            onTap: _pickDeadline,
          ),
          const SizedBox(height: 20),

          // --- Montant à bloquer ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Montant à bloquer',
                    style: TextStyle(color: colors.onPrimaryContainer),
                  ),
                ),
                Flexible(
                  child: Text(
                    formatFcfa(draft.totalToBlock),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: colors.onPrimaryContainer,
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

// Case cliquable avec un libellé au-dessus (date, heure, durée, date limite)
class _PickerBox extends StatelessWidget {
  const _PickerBox({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: colors.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}
