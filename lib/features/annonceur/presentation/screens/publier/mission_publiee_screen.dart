import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/published_mission.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/published_mission_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
import 'package:url_launcher/url_launcher.dart';

class MissionPublieeScreen extends ConsumerWidget {
  const MissionPublieeScreen({super.key});

  // Couleurs de cet écran (le vert est celui du splash dans le pubspec)
  static const _green = Color(0xFF1F6B4F);
  static const _panel = Color(0xFF174F3A);
  static const _cream = Color(0xFFFAF6EC);
  static const _amber = Color(0xFFE8B66B);

  Future<void> _shareOnWhatsApp(
    BuildContext context,
    PublishedMission mission,
  ) async {
    final d = mission.draft;
    final start = d.startAt;
    final when = start == null
        ? ''
        : ' · ${formatDay(start)} · ${formatHour(start)}';
    final text =
        'Nouvelle mission sur MicroOpportunités : ${d.title}$when'
        ' · ${formatPayPerUnit(d)}';
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
    final mission = ref.watch(publishedMissionControllerProvider);
    if (mission == null) {
      return Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () => context.go(AppRoutes.posterMissions),
            child: const Text('Retour à mes missions'),
          ),
        ),
      );
    }

    const white70 = Color(0xB3FFFFFF);

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
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${formatFcfa(mission.draft.totalToBlock)} sont bloqués. '
                          'Les exécutants de votre zone voient maintenant '
                          '« Paiement garanti ».',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: white70),
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
                                  color: Colors.white,
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
                        Text(
                          'Reçu envoyé · ${mission.receiptNumber}',
                          style: const TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 12,
                            color: Color(0x99FFFFFF),
                          ),
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
                      context.go(AppRoutes.posterMissionManage(mission.id)),
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
    child: Text(text, style: const TextStyle(color: Color(0xE6FFFFFF))),
  );
}
