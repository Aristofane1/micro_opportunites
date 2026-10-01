import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/applications/domain/entities/apply_target.dart';
import 'package:micro_opportunites/features/applications/presentation/controllers/applications_controller.dart';

/// Feuille « Postuler » (B06), ouverte comme une route.
class ApplySheet extends ConsumerStatefulWidget {
  const ApplySheet({super.key, required this.missionId});

  final String missionId;

  @override
  ConsumerState<ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends ConsumerState<ApplySheet> {
  final _message = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _send(ApplyTarget target) async {
    final result = await ref
        .read(applicationActionsProvider.notifier)
        .apply(missionId: widget.missionId, message: _message.text);
    if (!mounted) return;
    switch (result) {
      case Success():
        context.pushReplacement(WorkerPaths.applicationSent(target.posterName));
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sending = ref.watch(applicationActionsProvider).isLoading;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: AsyncValueView<ApplyTarget>(
        value: ref.watch(applyTargetProvider(widget.missionId)),
        onRetry: () => ref.invalidate(applyTargetProvider(widget.missionId)),
        data: (target) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            0,
            AppSpacing.screen,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Postuler', style: AppTypography.heading),
              const SizedBox(height: 4),
              Text(
                '${target.title} · ${formatShortDay(target.startAt)} · '
                '${formatFcfa(target.payAmount)}',
                style: AppTypography.caption.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Un mot pour l’annonceur (facultatif)',
                controller: _message,
                maxLines: 4,
                maxLength: 300,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.ivory,
                  borderRadius: AppRadius.tileAll,
                ),
                child: Text.rich(
                  const TextSpan(
                    children: [
                      TextSpan(
                        text: '✓ Pas de mission confirmée ce jour-là.\n',
                      ),
                      TextSpan(text: '✓ Si vous êtes retenu, vous devrez '),
                      TextSpan(
                        text: 'confirmer sous 12 h',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.toggleText,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  AppButton(
                    label: 'Annuler',
                    variant: AppButtonVariant.secondary,
                    expand: false,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'Envoyer ma candidature',
                      isLoading: sending,
                      onPressed: () => _send(target),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
