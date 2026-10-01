import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/presentation/controllers/applications_controller.dart';
import 'package:micro_opportunites/features/applications/presentation/widgets/application_card.dart';

/// Mes candidatures (B08), onglet Candidatures.
class ApplicationsPage extends ConsumerStatefulWidget {
  const ApplicationsPage({super.key});

  @override
  ConsumerState<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends ConsumerState<ApplicationsPage> {
  bool _showPast = false;

  Future<void> _refresh() async {
    try {
      ref.invalidate(myApplicationsProvider);
      await ref.read(myApplicationsProvider.future);
    } catch (_) {
      // L'erreur est affichée par ErrorView.
    }
  }

  Future<void> _withdraw(Application application) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Retirer ma candidature ?'),
        content: Text(
          '« ${application.mission.title} » ne sera plus proposée à l’annonceur.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Retirer'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final result = await ref
        .read(applicationActionsProvider.notifier)
        .withdraw(application.id);
    if (!mounted) return;
    showAppToast(context, switch (result) {
      Success() => 'Candidature retirée',
      Err(:final failure) => failure.message,
    });
  }

  void _open(Application application) {
    switch (application.status) {
      case ApplicationStatus.offered:
        context.push(WorkerPaths.offer(application.id));
      case ApplicationStatus.confirmed when application.assignmentId != null:
        context.push(WorkerPaths.assignment(application.assignmentId!));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = ref.watch(clockProvider)();
    return AsyncValueView<List<Application>>(
      value: ref.watch(myApplicationsProvider),
      onRetry: () => ref.invalidate(myApplicationsProvider),
      data: (all) {
        final current = all.where((a) => a.status.isCurrent).toList();
        final past = all.where((a) => !a.status.isCurrent).toList();
        final visible = _showPast ? past : current;
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            children: [
              const Text('Mes candidatures', style: AppTypography.title),
              const SizedBox(height: 14),
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.lineStrong),
                  ),
                ),
                child: Wrap(
                  spacing: AppSpacing.lg,
                  children: [
                    _TabLabel(
                      label: 'En cours (${current.length})',
                      selected: !_showPast,
                      onTap: () => setState(() => _showPast = false),
                    ),
                    _TabLabel(
                      label: 'Passées',
                      selected: _showPast,
                      onTap: () => setState(() => _showPast = true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              if (visible.isEmpty)
                _showPast
                    ? const EmptyState(title: 'Aucune candidature passée')
                    : EmptyState(
                        title: 'Pas encore de candidature',
                        message: 'Les missions de ta zone t’attendent.',
                        actionLabel: 'Explorer les missions',
                        onAction: () => context.go(WorkerPaths.explore),
                      )
              else
                for (final application in visible) ...[
                  ApplicationCard(
                    application: application,
                    now: now,
                    onTap:
                        application.status == ApplicationStatus.offered ||
                            application.status == ApplicationStatus.confirmed
                        ? () => _open(application)
                        : null,
                    onWithdraw: application.status == ApplicationStatus.pending
                        ? () => _withdraw(application)
                        : null,
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        );
      },
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSizes.minTouchTarget),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.green : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              color: selected ? AppColors.ink : AppColors.inkSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
