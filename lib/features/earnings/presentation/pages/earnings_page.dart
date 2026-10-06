import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';
import 'package:micro_opportunites/features/earnings/presentation/controllers/earnings_controller.dart';

/// Mes gains (B14), onglet Gains.
class EarningsPage extends ConsumerWidget {
  const EarningsPage({super.key});

  static String _missions(int count) =>
      count > 1 ? '$count missions' : '$count mission';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView<EarningsSummary>(
      value: ref.watch(earningsSummaryProvider),
      onRetry: () => ref.invalidate(earningsSummaryProvider),
      data: (summary) => RefreshIndicator(
        onRefresh: () async {
          try {
            ref.invalidate(earningsSummaryProvider);
            await ref.read(earningsSummaryProvider.future);
          } catch (_) {
            // L'erreur est affichée par ErrorView.
          }
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          children: [
            const Text('Mes gains', style: AppTypography.title),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _TotalTile(
                    label: 'À venir (réservé)',
                    amount: summary.upcomingAmount,
                    detail: 'FCFA · ${_missions(summary.upcomingCount)}',
                    background: AppColors.softOchre,
                    foreground: AppColors.ochreDeep,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _TotalTile(
                    label: 'Versés · ${summary.paidPeriodLabel}',
                    amount: summary.paidAmount,
                    detail: 'FCFA · ${_missions(summary.paidCount)}',
                    background: AppColors.softGreen,
                    foreground: AppColors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            AppListTile(
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.ochre,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'MoMo',
                  style: AppTypography.navLabel.copyWith(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: 'Versements sur',
              subtitle:
                  '${summary.payoutAccount.operator} · '
                  '${summary.payoutAccount.maskedNumber} · ${summary.payoutAccount.holderName}',
              onTap: () => showComingSoon(context, 'Compte de versement'),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Historique', style: AppTypography.subtitle),
            const SizedBox(height: 10),
            for (final line in summary.lines) ...[
              _EarningRow(
                line: line,
                onTap: line.payoutId == null
                    ? null
                    : () => context.push(WorkerPaths.payout(line.payoutId!)),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Aucune commission pendant la démo.',
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalTile extends StatelessWidget {
  const _TotalTile({
    required this.label,
    required this.amount,
    required this.detail,
    required this.background,
    required this.foreground,
  });

  final String label;
  final int amount;
  final String detail;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.cardAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption.copyWith(color: foreground)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatAmount(amount),
              style: AppTypography.title.copyWith(color: foreground),
            ),
          ),
          Text(detail, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _EarningRow extends StatelessWidget {
  const _EarningRow({required this.line, required this.onTap});

  final EarningLine line;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = switch (line.status) {
      EarningStatus.paid =>
        'Versé · ${formatShortDate(line.date)} · voir le reçu',
      EarningStatus.awaitingValidation => 'À valider par l’annonceur',
      EarningStatus.reserved => 'Réservé · ${formatShortDay(line.date)}',
    };
    final paid = line.status == EarningStatus.paid;
    return Material(
      color: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.tileAll,
        side: BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(line.title, style: AppTypography.bodyStrong),
                    Text(subtitle, style: AppTypography.caption),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                paid
                    ? '+ ${formatAmount(line.amount)}'
                    : formatAmount(line.amount),
                style: AppTypography.bodyStrong.copyWith(
                  color: paid ? AppColors.green : AppColors.inkSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
