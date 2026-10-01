import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_avatar.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/missions/domain/entities/poster_profile.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_detail_controller.dart';

/// Profil public d'un annonceur (B17).
class PosterProfilePage extends ConsumerWidget {
  const PosterProfilePage({super.key, required this.posterId});

  final String posterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: AsyncValueView<PosterProfile>(
          value: ref.watch(posterProfileProvider(posterId)),
          onRetry: () => ref.invalidate(posterProfileProvider(posterId)),
          data: (profile) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.xs,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            children: [
              Row(
                children: [
                  RoundIconButton(
                    icon: AppIcons.back,
                    semanticLabel: 'Retour',
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  RoundIconButton(
                    icon: AppIcons.more,
                    semanticLabel: 'Signaler ou bloquer',
                    onPressed: () => showComingSoon(context, 'Signalement'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Center(child: AppAvatar(name: profile.displayName, size: 72)),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Text(profile.displayName, style: AppTypography.heading),
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  if (profile.verified)
                    const _Badge(
                      label: '✓ Identité vérifiée',
                      background: AppColors.softGreen,
                      foreground: AppColors.green,
                    ),
                  if (profile.reliable)
                    const _Badge(
                      label: 'Annonceur fiable',
                      background: AppColors.softOchre,
                      foreground: AppColors.ochreDeep,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${profile.city} · membre depuis ${formatMonthYear(profile.memberSince)}',
                textAlign: TextAlign.center,
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      value: formatRating(profile.rating),
                      label: 'note · ${profile.reviewsCount} avis',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _StatTile(
                      value: '${profile.paidMissions}',
                      label: 'missions payées',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _StatTile(
                      value: '${profile.avgValidationHours} h',
                      label: 'pour valider',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text('Avis des exécutants', style: AppTypography.subtitle),
              const SizedBox(height: AppSpacing.sm),
              for (final review in profile.reviews) ...[
                _ReviewCard(review: review),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.pillAll,
      ),
      child: Text(
        label,
        style: AppTypography.small.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: AppRadius.tileAll,
      ),
      child: Column(
        children: [
          Text(value, style: AppTypography.headingSmall),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final stars = '${'★' * review.stars}${'☆' * (5 - review.stars)}';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: AppRadius.tileAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(review.authorName, style: AppTypography.bodyStrong),
              ),
              Semantics(
                label: '${review.stars} étoiles sur 5',
                excludeSemantics: true,
                child: Text(
                  stars,
                  style: AppTypography.body.copyWith(
                    color: AppColors.ochreDeep,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(review.comment, style: AppTypography.body),
          const SizedBox(height: 4),
          Text(
            '${review.context} · ${formatMonthYear(review.date)}',
            style: AppTypography.caption,
          ),
          if (review.reply != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.ivory,
                borderRadius: AppRadius.fieldAll,
              ),
              child: Text(
                'Réponse : ${review.reply}',
                style: AppTypography.caption,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
