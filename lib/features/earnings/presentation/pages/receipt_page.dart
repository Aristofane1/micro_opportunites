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
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_logo.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/payout.dart';
import 'package:micro_opportunites/features/earnings/presentation/controllers/earnings_controller.dart';

/// Reçu de versement (B15).
class ReceiptPage extends ConsumerWidget {
  const ReceiptPage({super.key, required this.payoutId});

  final String payoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: AsyncValueView<Payout>(
          value: ref.watch(payoutProvider(payoutId)),
          onRetry: () => ref.invalidate(payoutProvider(payoutId)),
          data: (payout) => ListView(
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
              const SizedBox(height: AppSpacing.sm),
              const Text('Reçu de versement', style: AppTypography.title),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border.all(color: AppColors.line),
                  borderRadius: AppRadius.cardAll,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Flexible(
                          child: AppLogo(
                            variant: AppLogoVariant.short,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: AppSpacing.xs),
                        StatusBadge(
                          MissionStatusKind.completedPaid,
                          label: 'Versé',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Text('Montant reçu', style: AppTypography.caption),
                    Text(
                      formatFcfa(payout.amount),
                      style: AppTypography.amount.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Divider(),
                    _ReceiptRow(label: 'Mission', value: payout.missionTitle),
                    _ReceiptRow(label: 'Annonceur', value: payout.posterName),
                    _ReceiptRow(
                      label: 'Validée le',
                      value: formatLongDateTime(payout.validatedAt),
                    ),
                    const Divider(),
                    _ReceiptRow(
                      label: 'Rémunération',
                      value: formatFcfa(payout.grossAmount),
                    ),
                    _ReceiptRow(
                      label: 'Commission',
                      value: payout.commissionLabel,
                    ),
                    _ReceiptRow(label: 'Versé sur', value: payout.accountLabel),
                    _ReceiptRow(
                      label: 'Référence',
                      value: payout.reference,
                      mono: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Télécharger (PDF)',
                variant: AppButtonVariant.secondary,
                onPressed: () =>
                    showComingSoon(context, 'Téléchargement du reçu'),
              ),
              const SizedBox(height: AppSpacing.xs),
              Center(
                child: TextButton(
                  onPressed: () => showComingSoon(context, 'Aide'),
                  child: const Text('Un problème ?'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.label,
    required this.value,
    this.mono = false,
  });

  final String label;
  final String value;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: AppTypography.caption),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: mono ? AppTypography.reference : AppTypography.label,
            ),
          ),
        ],
      ),
    );
  }
}
