import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

const _red = Color(0xFFB42318);

enum _Problem {
  incomplete('Travail incomplet'),
  poor('Travail mal fait'),
  leftEarly('Parti avant la fin'),
  misconduct('Comportement inapproprié');

  const _Problem(this.label);
  final String label;
}

class SignalerProblemeScreen extends ConsumerStatefulWidget {
  const SignalerProblemeScreen({
    super.key,
    required this.missionId,
    required this.candidateId,
  });

  final String missionId;
  final String candidateId;

  @override
  ConsumerState<SignalerProblemeScreen> createState() =>
      _SignalerProblemeScreenState();
}

class _SignalerProblemeScreenState
    extends ConsumerState<SignalerProblemeScreen> {
  _Problem? _kind;
  final _textCtrl = TextEditingController();
  final List<String> _photos = [];

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  bool get _valid => _kind != null && _textCtrl.text.trim().isNotEmpty;

  Future<void> _pickPhoto() async {
    if (_photos.length >= 3) return;
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    setState(() => _photos.add(file.path));
  }

  void _submit() {
    ref
        .read(candidatesControllerProvider.notifier)
        .openDispute(
          widget.missionId,
          widget.candidateId,
          '${_kind!.label} : ${_textCtrl.text.trim()}',
        );
    final messenger = ScaffoldMessenger.of(context);
    context.pop();
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Litige ouvert. Un médiateur répond sous 24 h (simulation).',
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
    final c = ref.watch(
      candidatesControllerProvider.select(
        (m) => (m[widget.missionId] ?? const <Candidate>[])
            .where((x) => x.id == widget.candidateId)
            .firstOrNull,
      ),
    );

    if (mission == null || c == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Introuvable.')),
      );
    }

    final amount = mission.amountPerSlot + c.bonusAmount;

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
                        const Expanded(
                          child: Text(
                            'Signaler un problème',
                            style: TextStyle(
                              fontFamily: 'Lora',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Les ${formatFcfa(amount)} de ${c.firstName} restent '
                      'bloqués pendant l\'examen. Un médiateur répond sous '
                      '24 h. Avant, essayez d\'en parler avec lui : beaucoup '
                      'de soucis se règlent ainsi.',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 18),

                    // --- Type de problème ---
                    const Text(
                      'Quel est le problème ?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    for (final p in _Problem.values) ...[
                      _ProblemTile(
                        label: p.label,
                        selected: _kind == p,
                        onTap: () => setState(() => _kind = p),
                      ),
                      const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 8),

                    // --- Explication ---
                    const Text(
                      'Expliquez',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _textCtrl,
                      onChanged: (_) => setState(() {}),
                      minLines: 3,
                      maxLines: 6,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Décrivez ce qui s\'est passé…',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- Photos ---
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final path in _photos)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(path),
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                        if (_photos.length < 3)
                          OutlinedButton(
                            onPressed: _pickPhoto,
                            child: const Text('+ Ajouter des photos'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(top: BorderSide(color: colors.outlineVariant)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _valid ? _submit : null,
                  child: const Text('Ouvrir un litige'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProblemTile extends StatelessWidget {
  const _ProblemTile({
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
            color: selected ? _red : colors.outlineVariant,
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
