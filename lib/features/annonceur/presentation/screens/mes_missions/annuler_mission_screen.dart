import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/info_card.dart';

/// C14 : annulation d'une mission ; l'argent bloqué est débloqué.
class AnnulerMissionScreen extends ConsumerStatefulWidget {
  const AnnulerMissionScreen({super.key, required this.missionId});

  final String missionId;

  @override
  ConsumerState<AnnulerMissionScreen> createState() =>
      _AnnulerMissionScreenState();
}

class _AnnulerMissionScreenState extends ConsumerState<AnnulerMissionScreen> {
  String? _error;
  int? _amountBefore;

  Future<void> _cancel() async {
    setState(() => _error = null);
    // Montant lu avant l'action : après l'annulation il retombe à 0.
    _amountBefore = ref
        .read(posterMissionProvider(widget.missionId))
        .value
        ?.blockedAmount;
    final result = await ref
        .read(annonceurActionsProvider.notifier)
        .cancel(widget.missionId);
    if (!mounted) return;
    switch (result) {
      case Success():
        context.go(PosterPaths.missions);
      case Err(:final failure):
        setState(() => _error = failure.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final missionProvider = posterMissionProvider(widget.missionId);
    final candidatesProvider = missionCandidatesProvider(widget.missionId);
    final missionValue = ref.watch(missionProvider);
    final candidatesValue = ref.watch(candidatesProvider);
    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueView(
        value: missionValue,
        onRetry: () => ref.invalidate(missionProvider),
        data: (mission) => AsyncValueView(
          value: candidatesValue,
          onRetry: () => ref.invalidate(candidatesProvider),
          data: (all) => _content(mission, all),
        ),
      ),
    );
  }

  Widget _content(MissionSummary mission, List<Candidate> all) {
    final busy = ref.watch(annonceurActionsProvider).isLoading;
    final notified = all
        .where(
          (c) =>
              c.status == CandidateStatus.retained ||
              c.status == CandidateStatus.confirmed,
        )
        .toList();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Annuler la mission', style: AppTypography.title),
            const SizedBox(height: AppSpacing.xs),
            Text(mission.title, style: AppTypography.caption),
            const SizedBox(height: AppSpacing.md),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Argent débloqué', style: AppTypography.label),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    formatFcfa(_amountBefore ?? mission.blockedAmount),
                    style: AppTypography.amount,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Personnes prévenues', style: AppTypography.bodyStrong),
            const SizedBox(height: AppSpacing.xs),
            if (notified.isEmpty)
              const Text(
                'Personne n’a encore été retenu(e).',
                style: AppTypography.caption,
              )
            else
              for (final c in notified)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                  child: Text(c.name, style: AppTypography.body),
                ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Annuler la mission',
              variant: AppButtonVariant.destructive,
              onPressed: busy ? null : _cancel,
              isLoading: busy,
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              AppBanner(tone: AppBannerTone.error, message: _error!),
            ],
          ],
        ),
      ),
    );
  }
}
