import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/core/ui/widgets/filter_pill.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';
import 'package:micro_opportunites/features/alerts/presentation/controllers/alerts_controller.dart';

/// Mes alertes de missions (B16).
class AlertsPage extends ConsumerWidget {
  const AlertsPage({super.key, this.initialKeyword});

  /// Mot-clé venu d'une recherche sans résultat (B04).
  final String? initialKeyword;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MissionAlert alert,
  ) async {
    final result = await ref
        .read(alertActionsProvider.notifier)
        .delete(alert.id);
    if (!context.mounted) return;
    showAppToast(context, switch (result) {
      Success() => 'Alerte supprimée',
      Err(:final failure) => failure.message,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            const Text('Mes alertes', style: AppTypography.title),
            const SizedBox(height: 6),
            Text(
              'On vous prévient dès qu’une mission correspond. Les premiers à '
              'postuler sont souvent retenus.',
              style: AppTypography.body.copyWith(color: AppColors.toggleText),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncValueView<List<MissionAlert>>(
              value: ref.watch(myAlertsProvider),
              onRetry: () => ref.invalidate(myAlertsProvider),
              data: (alerts) => alerts.isEmpty
                  ? const EmptyState(title: 'Aucune alerte pour l’instant')
                  : Column(
                      children: [
                        for (final alert in alerts) ...[
                          _AlertTile(
                            key: ValueKey('alert.${alert.id}'),
                            alert: alert,
                            onDelete: () => _delete(context, ref, alert),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                        ],
                      ],
                    ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Nouvelle alerte', style: AppTypography.subtitle),
            const SizedBox(height: 10),
            _AlertForm(initialKeyword: initialKeyword),
          ],
        ),
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({super.key, required this.alert, required this.onDelete});

  final MissionAlert alert;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: AppRadius.tileAll,
      ),
      child: Row(
        children: [
          const AppIcon(
            AppIcons.notifications,
            size: 20,
            color: AppColors.green,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.title, style: AppTypography.bodyStrong),
                Text(alert.subtitle, style: AppTypography.caption),
              ],
            ),
          ),
          Semantics(
            button: true,
            label: 'Supprimer l’alerte ${alert.title}',
            excludeSemantics: true,
            onTap: onDelete,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onDelete,
              child: const SizedBox.square(
                dimension: AppSizes.minTouchTarget,
                child: Center(
                  child: AppIcon(
                    AppIcons.delete,
                    size: 20,
                    color: AppColors.inkSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertForm extends ConsumerStatefulWidget {
  const _AlertForm({this.initialKeyword});

  final String? initialKeyword;

  @override
  ConsumerState<_AlertForm> createState() => _AlertFormState();
}

class _AlertFormState extends ConsumerState<_AlertForm> {
  static const _categories = [
    'Événement',
    'Livraison',
    'Courses',
    'Informatique',
    'Saisie de données',
    'Nettoyage',
    'Réparation',
    'Flyers',
  ];
  static const _zones = [
    '5 km autour de moi',
    '10 km autour de moi',
    'Abomey-Calavi',
    'Cotonou',
    'Cotonou et Calavi',
  ];
  static const _minPays = [2000, 5000, 10000];
  static const _dayOptions = [
    everyDayLabel,
    'En semaine',
    'Week-end seulement',
  ];

  late String? _keyword = widget.initialKeyword;
  String? _category;
  String _zone = _zones.first;
  int? _minPay;
  String _days = everyDayLabel;

  /// Change après chaque création pour réinitialiser les listes déroulantes.
  int _generation = 0;

  Future<void> _create() async {
    final result = await ref
        .read(alertActionsProvider.notifier)
        .create(
          AlertDraft(
            keyword: _keyword,
            category: _category,
            zone: _zone,
            minPay: _minPay,
            days: _days,
          ),
        );
    if (!mounted) return;
    switch (result) {
      case Success():
        showAppToast(context, 'Alerte créée');
        setState(() {
          _keyword = null;
          _category = null;
          _zone = _zones.first;
          _minPay = null;
          _days = everyDayLabel;
          _generation++;
        });
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(alertActionsProvider).isLoading;
    return Column(
      key: ValueKey(_generation),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_keyword != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: FilterPill(
              label: '« $_keyword »',
              state: FilterPillState.applied,
              onTap: () => setState(() => _keyword = null),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        DropdownButtonFormField<String?>(
          isExpanded: true,
          initialValue: _category,
          decoration: const InputDecoration(labelText: 'Catégorie'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('Toutes catégories'),
            ),
            for (final category in _categories)
              DropdownMenuItem(value: category, child: Text(category)),
          ],
          onChanged: (value) => setState(() => _category = value),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: _zone,
          decoration: const InputDecoration(labelText: 'Zone'),
          items: [
            for (final zone in _zones)
              DropdownMenuItem(value: zone, child: Text(zone)),
          ],
          onChanged: (value) => setState(() => _zone = value ?? _zones.first),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<int?>(
          isExpanded: true,
          initialValue: _minPay,
          decoration: const InputDecoration(labelText: 'Montant minimum'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Peu importe')),
            for (final amount in _minPays)
              DropdownMenuItem(value: amount, child: Text(formatFcfa(amount))),
          ],
          onChanged: (value) => setState(() => _minPay = value),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: _days,
          decoration: const InputDecoration(labelText: 'Jours'),
          items: [
            for (final days in _dayOptions)
              DropdownMenuItem(value: days, child: Text(days)),
          ],
          onChanged: (value) => setState(() => _days = value ?? everyDayLabel),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(label: 'Créer l’alerte', isLoading: busy, onPressed: _create),
      ],
    );
  }
}
