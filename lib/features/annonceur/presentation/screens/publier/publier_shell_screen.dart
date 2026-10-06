import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/step_progress_bar.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/etape_quoi_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/etape_ou_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/etape_quand_combien_screen.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';

class PublierShellScreen extends ConsumerStatefulWidget {
  const PublierShellScreen({super.key});

  @override
  ConsumerState<PublierShellScreen> createState() => _PublierShellScreenState();
}

class _PublierShellScreenState extends ConsumerState<PublierShellScreen> {
  static const _labels = ['Quoi', 'Où', 'Quand et combien'];
  static const _nextLabels = [
    'Suivant : où',
    'Suivant : quand et combien',
    'Publier',
  ];

  int _step = 0;

  bool _filled(String? value) => value != null && value.trim().isNotEmpty;

  bool _canContinue(MissionDraft draft) => switch (_step) {
    0 =>
      _filled(draft.title) &&
          draft.category != null &&
          _filled(draft.description),
    1 => _filled(draft.city) && _filled(draft.address),
    2 =>
      draft.startAt != null &&
          (draft.payAmount ?? 0) > 0 &&
          draft.slotsTotal >= 1 &&
          draft.applyDeadline != null &&
          draft.applyDeadline!.isBefore(draft.startAt!),
    _ => true,
  };

  void _next() {
    if (_step < _labels.length - 1) {
      setState(() => _step++);
    } else {
      _publish();
    }
  }

  /// Publie : l'argent est bloqué sur le solde, puis écran de confirmation.
  Future<void> _publish() async {
    final result = await ref.read(annonceurActionsProvider.notifier).publish();
    if (!mounted) return;
    switch (result) {
      case Success():
        context.go(PosterPaths.publishDone);
      case Err(:final failure):
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
    }
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
    } else if (context.canPop()) {
      context.pop(); // ouvert depuis l'onglet : on revient
    } else {
      context.go(
        PosterPaths.publish,
      ); // ouvert directement : on va à l'onglet Publier
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(missionDraftControllerProvider);
    final publishing = ref.watch(annonceurActionsProvider).isLoading;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton.outlined(
                            onPressed: _back,
                            icon: Icon(
                              _step == 0 ? Icons.close : Icons.arrow_back,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Nouvelle mission',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _step == 0
                                ? 'Brouillon '
                                : '${_step + 1}/${_labels.length}',
                            style: TextStyle(color: colors.onSurfaceVariant),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  StepProgressBar(current: _step, total: _labels.length),
                  const SizedBox(height: 12),
                  //  l'étape actuelle en gras
                  Text.rich(
                    TextSpan(
                      children: [
                        for (var i = 0; i < _labels.length; i++) ...[
                          TextSpan(
                            text: _labels[i],
                            style: TextStyle(
                              fontWeight: i == _step
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: i == _step
                                  ? colors.onSurface
                                  : colors.onSurfaceVariant,
                            ),
                          ),
                          if (i < _labels.length - 1)
                            const TextSpan(text: ' · '),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Contenu de l'étape
            Expanded(
              child: switch (_step) {
                0 => const EtapeQuoiScreen(),
                1 => const EtapeOuScreen(),
                _ => const EtapeQuandCombienScreen(),
              },
            ),
            // Bouton du bas
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _canContinue(draft) && !publishing
                          ? _next
                          : null,
                      child: Text(_nextLabels[_step]),
                    ),
                  ),
                  if (_step == _labels.length - 1) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${formatFcfa(draft.totalToBlock)} seront bloqués sur '
                      'votre solde.',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
