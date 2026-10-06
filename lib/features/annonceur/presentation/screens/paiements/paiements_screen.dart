import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/wallet.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';

/// C15 : onglet Paiements de l'annonceur.
class PaiementsScreen extends ConsumerWidget {
  const PaiementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(walletProvider),
      onRetry: () => ref.invalidate(walletProvider),
      data: (wallet) => ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.xl,
        ),
        children: [
          const Text('Paiements', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          _BalanceCard(wallet: wallet),
          const SizedBox(height: AppSpacing.lg),
          const Text('Bloqué pour vos missions', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.xs),
          if (wallet.blocked.isEmpty)
            const EmptyState(title: 'Aucun montant bloqué.')
          else
            for (final b in wallet.blocked)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: AppListTile(
                  title: b.title,
                  showChevron: false,
                  leading: Text(
                    formatFcfa(b.amount),
                    style: AppTypography.bodyStrong,
                  ),
                ),
              ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Versements effectués', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.xs),
          if (wallet.payouts.isEmpty)
            const EmptyState(title: 'Aucun versement pour le moment.')
          else
            for (final p in wallet.payouts)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: AppListTile(
                  title: p.missionTitle,
                  subtitle: '${p.workerName} · ${formatShortDate(p.paidAt)}',
                  showChevron: false,
                  leading: Text(
                    formatFcfa(p.amount),
                    style: AppTypography.bodyStrong,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    Widget line(String label, int amount) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.label),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(formatFcfa(amount), style: AppTypography.amount),
          ),
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          line('Solde', wallet.balance),
          const SizedBox(height: AppSpacing.sm),
          line('Disponible', wallet.available),
        ],
      ),
    );
  }
}
