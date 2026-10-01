import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';

/// Fin signalée, en attente de validation (B13) — ou payée.
class AwaitingValidationView extends StatelessWidget {
  const AwaitingValidationView({super.key, required this.assignment});

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    final paid = assignment.status == AssignmentStatus.paid;
    final deadline = assignment.autoValidateAt;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.xs,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RoundIconButton(
            icon: AppIcons.back,
            semanticLabel: 'Retour',
            onPressed: () => context.pop(),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.softGreen,
              shape: BoxShape.circle,
            ),
            child: const AppIcon(
              AppIcons.check,
              size: 48,
              color: AppColors.green,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          paid ? 'Mission payée' : 'Bravo, c’est envoyé',
          textAlign: TextAlign.center,
          style: AppTypography.title,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          paid || deadline == null
              ? '${formatFcfa(assignment.payAmount)} ont été versés sur ${assignment.payoutOperator}.'
              : '${assignment.posterName} doit valider votre travail. Au plus tard '
                    '${formatShortDay(deadline)} à ${formatHour(deadline)}, vous êtes payé '
                    'automatiquement.',
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(color: AppColors.toggleText),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Step(
          number: 1,
          done: true,
          label:
              'Fin signalée · ${assignment.checkOutAt == null ? '' : formatHour(assignment.checkOutAt!)}',
        ),
        _Step(
          number: 2,
          done: paid,
          current: !paid,
          label: 'Validation par l’annonceur',
        ),
        _Step(
          number: 3,
          done: paid,
          label:
              'Versement de ${formatFcfa(assignment.payAmount)} sur ${assignment.payoutOperator}',
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Noter l’annonceur',
          variant: AppButtonVariant.secondary,
          onPressed: () => showComingSoon(context, 'Notation'),
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Voir mes gains',
          onPressed: () => context.go(WorkerPaths.earnings),
        ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.done,
    required this.label,
    this.current = false,
  });

  final int number;
  final bool done;
  final bool current;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color background = done ? AppColors.green : AppColors.card;
    final Color border = done
        ? AppColors.green
        : current
        ? AppColors.ochreDeep
        : AppColors.lineStrong;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
              border: Border.all(color: border, width: 2),
            ),
            child: done
                ? const AppIcon(
                    AppIcons.check,
                    size: 16,
                    color: AppColors.white,
                  )
                : Text(
                    '$number',
                    style: AppTypography.small.copyWith(
                      color: current
                          ? AppColors.ochreDeep
                          : AppColors.inkSecondary,
                    ),
                  ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTypography.label.copyWith(
                color: done || current ? AppColors.ink : AppColors.inkSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
