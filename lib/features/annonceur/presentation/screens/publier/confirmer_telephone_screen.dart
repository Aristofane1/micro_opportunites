import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/published_mission_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

class ConfirmerTelephoneScreen extends ConsumerStatefulWidget {
  const ConfirmerTelephoneScreen({super.key});

  @override
  ConsumerState<ConfirmerTelephoneScreen> createState() =>
      _ConfirmerTelephoneScreenState();
}

class _ConfirmerTelephoneScreenState
    extends ConsumerState<ConfirmerTelephoneScreen> {
  static const _timeoutSeconds = 120;

  // Copiés au départ : le brouillon est vidé juste après la publication
  late final int _total;
  late final String _methodLabel;

  Timer? _timer;
  int _remaining = _timeoutSeconds;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(missionDraftControllerProvider);
    _total = draft.totalToBlock;
    _methodLabel = draft.paymentMethod.label;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 1) {
        timer.cancel();
        setState(() => _remaining = 0);
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _clock =>
      '${_remaining ~/ 60}:${(_remaining % 60).toString().padLeft(2, '0')}';

  Future<void> _confirm() async {
    setState(() => _loading = true);
    try {
      await ref
          .read(publishedMissionControllerProvider.notifier)
          .payAndPublish();
      if (!mounted) return;
      context.go(AppRoutes.posterPublishDone);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le paiement n\'a pas abouti. Réessayez.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final expired = _remaining == 0;

    return PopScope(
      canPop: !_loading, // pas de retour arrière pendant le traitement
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryContainer,
                              border: Border.all(
                                color: colors.primary.withValues(alpha: 0.5),
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              Icons.smartphone_outlined,
                              size: 56,
                              color: colors.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Confirmez sur votre téléphone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lora',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '$_methodLabel vous envoie une demande '
                                      'de paiement. Tapez votre ',
                                ),
                                const TextSpan(
                                  text: 'code secret Mobile Money',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const TextSpan(text: ' pour valider.'),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // --- Montant ---
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: colors.outlineVariant),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Montant',
                                  style: TextStyle(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: groupThousands(_total),
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
                          ),
                          const SizedBox(height: 16),

                          // --- Compte à rebours ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: expired ? colors.error : Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                expired
                                    ? 'Délai dépassé'
                                    : 'En attente de votre confirmation · $_clock',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // --- Avertissement de sécurité ---
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'MicroOpportunités ne vous demandera jamais votre '
                              'code secret. Ne le tapez que dans le menu de '
                              'votre opérateur.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- Boutons du bas ---
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.onSurface,
                      foregroundColor: colors.surface,
                    ),
                    onPressed: (_loading || expired) ? null : _confirm,
                    child: _loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          )
                        : const Text('J\'ai confirmé'),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _loading ? null : () => context.pop(),
                  child: const Text('Je n\'ai rien reçu · changer de moyen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
