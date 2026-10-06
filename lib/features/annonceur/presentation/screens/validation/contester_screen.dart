import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';

/// C13 : l'annonceur conteste le travail ; le versement est suspendu.
class ContesterScreen extends ConsumerStatefulWidget {
  const ContesterScreen({
    super.key,
    required this.missionId,
    required this.assignmentId,
  });

  final String missionId;
  final String assignmentId;

  @override
  ConsumerState<ContesterScreen> createState() => _ContesterScreenState();
}

class _ContesterScreenState extends ConsumerState<ContesterScreen> {
  final _reason = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _reason.text.trim();
    if (reason.isEmpty) {
      setState(() => _error = 'Indiquez le motif.');
      return;
    }
    setState(() => _error = null);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(annonceurActionsProvider.notifier)
        .contest(widget.assignmentId, reason);
    if (!mounted) return;
    switch (result) {
      case Success():
        context.go(PosterPaths.missionManage(widget.missionId));
        messenger.showSnackBar(
          const SnackBar(content: Text('Contestation envoyée.')),
        );
      case Err(:final failure):
        messenger.showSnackBar(SnackBar(content: Text(failure.message)));
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
          data: (all) {
            final c = all
                .where((x) => x.assignmentId == widget.assignmentId)
                .firstOrNull;
            if (c == null) return const Center(child: Text('Introuvable.'));
            return _form(mission, c);
          },
        ),
      ),
    );
  }

  Widget _form(MissionSummary mission, Candidate c) {
    final busy = ref.watch(annonceurActionsProvider).isLoading;
    final finished = c.finishedAt;
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
            const Text('Contester le travail', style: AppTypography.title),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mission.title, style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(c.name, style: AppTypography.bodyStrong),
                  Text(
                    finished == null
                        ? 'n’a pas encore signalé la fin'
                        : 'a signalé la fin à ${formatHour(finished)}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const AppBanner(
              tone: AppBannerTone.todo,
              message:
                  'Le versement est suspendu pendant l’examen. L’équipe vous contactera.',
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Motif',
              hint: 'Décrivez ce qui ne va pas',
              controller: _reason,
              maxLines: 4,
              errorText: _error,
              enabled: !busy,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Contester',
              onPressed: busy ? null : _submit,
              isLoading: busy,
            ),
          ],
        ),
      ),
    );
  }
}
