import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

/// Candidature envoyée (B07).
class ApplicationSentPage extends StatelessWidget {
  const ApplicationSentPage({super.key, required this.posterName});

  final String posterName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Container(
                        width: 120,
                        height: 120,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.softGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const AppIcon(
                          AppIcons.check,
                          size: 56,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Candidature envoyée',
                        textAlign: TextAlign.center,
                        style: AppTypography.title,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '$posterName répond en général dans la journée. On vous '
                        'prévient dès qu’une décision est prise.',
                        textAlign: TextAlign.center,
                        style: AppTypography.body.copyWith(
                          color: AppColors.toggleText,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const AppBanner(
                        tone: AppBannerTone.offline,
                        title: 'Hors-ligne ?',
                        message:
                            'Pas de souci : la candidature reste « en attente '
                            'd’envoi » et part toute seule au retour du réseau.',
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                label: 'Suivre mes candidatures',
                onPressed: () => context.go(WorkerPaths.applications),
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'Voir d’autres missions',
                variant: AppButtonVariant.secondary,
                onPressed: () => context.go(WorkerPaths.explore),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
