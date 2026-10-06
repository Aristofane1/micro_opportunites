import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class MissionPublieeScreen extends ConsumerWidget {
  const MissionPublieeScreen({super.key});

  // Couleurs de cet écran (le vert est celui du splash dans le pubspec)
  static const _green = AppColors.green;
  static const _panel = AppColors.greenDark;
  static const _cream = AppColors.cream;
  static const _amber = AppColors.ochre;

  Future<void> _shareOnWhatsApp(
    BuildContext context,
    MissionSummary mission,
  ) async {
    final start = mission.startAt;
    final text =
        'Nouvelle mission sur MicroOpportunités : ${mission.title}'
        ' · ${formatShortDay(start)} · ${formatHour(start)}'
        ' · ${mission.payLabel}';
    final uri = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(text)}');

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mission = ref.watch(lastPublishedProvider);
    if (mission == null) {
      return Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () => context.go(PosterPaths.missions),
            child: const Text('Retour à mes missions'),
          ),
        ),
      );
    }

    final white70 = AppColors.white.withValues(alpha: 0.7);

    return Scaffold(
      backgroundColor: _green,
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
                        // Épingle avec chevron
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 110,
                                color: _cream,
                              ),
                              Positioned(
                                top: 26,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: _amber,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_arrow_up,
                                    color: _green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Votre mission est en ligne',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${formatFcfa(mission.blockedAmount)} sont bloqués. '
                          'Les exécutants de votre zone voient maintenant '
                          '« Paiement garanti ».',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: white70),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Et maintenant ?',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              _Step('1. Vous recevez les candidatures.'),
                              _Step('2. Vous choisissez, ils confirment.'),
                              _Step(
                                '3. Vous validez le travail, ils sont payés.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Montant bloqué',
                                style: TextStyle(color: white70),
                              ),
                            ),
                            Text(
                              formatFcfa(mission.blockedAmount),
                              style: const TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _cream,
                    foregroundColor: _green,
                  ),
                  onPressed: () =>
                      context.go(PosterPaths.missionManage(mission.id)),
                  child: const Text('Suivre ma mission'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _cream,
                    side: const BorderSide(color: _cream),
                  ),
                  onPressed: () => _shareOnWhatsApp(context, mission),
                  child: const Text('Partager sur WhatsApp'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(
      text,
      style: TextStyle(color: AppColors.white.withValues(alpha: 0.9)),
    ),
  );
}
