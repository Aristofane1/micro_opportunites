import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';

/// Mission en cours (B11) : chrono depuis le check-in.
class InProgressView extends ConsumerStatefulWidget {
  const InProgressView({super.key, required this.assignment});

  final Assignment assignment;

  @override
  ConsumerState<InProgressView> createState() => _InProgressViewState();
}

class _InProgressViewState extends ConsumerState<InProgressView> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assignment = widget.assignment;
    final now = ref.watch(clockProvider)();
    final checkInAt = assignment.checkInAt ?? now;
    final elapsed = now.difference(checkInAt);

    return ListView(
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
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.red,
                side: const BorderSide(color: AppColors.red),
                shape: const StadiumBorder(),
              ),
              onPressed: () => showComingSoon(context, 'Urgence'),
              child: const Text('Urgence'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'EN COURS',
          style: AppTypography.small.copyWith(
            color: AppColors.blue,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formatDuration(elapsed.isNegative ? Duration.zero : elapsed),
          style: AppTypography.hero.copyWith(fontSize: 44),
        ),
        Text(
          'sur place · fin prévue vers ${formatHour(checkInAt.add(assignment.duration))}',
          style: AppTypography.caption,
        ),
        const SizedBox(height: AppSpacing.md),
        AppBanner(
          title: '✓ Check-in enregistré à ${formatHour(checkInAt)}',
          message:
              '· à ${assignment.checkInDistanceMeters ?? 0} m du lieu · '
              'l’annonceur a été prévenu',
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.card,
            border: Border.all(color: AppColors.line),
            borderRadius: AppRadius.cardAll,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(assignment.title, style: AppTypography.subtitle),
              const SizedBox(height: 4),
              Text(
                '${assignment.district} · ${assignment.briefing}',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: AppColors.softOchre,
            borderRadius: AppRadius.tileAll,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Réservé pour vous',
                  style: AppTypography.label.copyWith(
                    color: AppColors.ochreDeep,
                  ),
                ),
              ),
              Text(
                formatFcfa(assignment.payAmount),
                style: AppTypography.amount.copyWith(
                  color: AppColors.ochreDeep,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Message',
                icon: AppIcons.messages,
                variant: AppButtonVariant.secondary,
                onPressed: () => showComingSoon(context, 'Messagerie'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                label: 'Partager à un proche',
                variant: AppButtonVariant.secondary,
                onPressed: () => showComingSoon(context, 'Partage de trajet'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'J’ai terminé',
          icon: AppIcons.check,
          onPressed: () => context.push(WorkerPaths.reportEnd(assignment.id)),
        ),
      ],
    );
  }
}
