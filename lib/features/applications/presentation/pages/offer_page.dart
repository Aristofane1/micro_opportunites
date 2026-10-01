import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/error/result.dart';
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
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/presentation/controllers/applications_controller.dart';

/// Offre reçue (B09) : confirmer ou décliner.
class OfferPage extends ConsumerWidget {
  const OfferPage({super.key, required this.applicationId});

  final String applicationId;

  bool _isOpen(Application application, WidgetRef ref) {
    if (application.status != ApplicationStatus.offered) return false;
    final expiresAt = application.offerExpiresAt;
    return expiresAt == null || !expiresAt.isBefore(ref.read(clockProvider)());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: AsyncValueView<Application>(
          value: ref.watch(applicationDetailProvider(applicationId)),
          onRetry: () => ref.invalidate(myApplicationsProvider),
          data: (application) => _isOpen(application, ref)
              ? _OfferBody(application: application)
              : ListView(
                  padding: const EdgeInsets.all(AppSpacing.screen),
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
                    EmptyState(
                      title: 'Cette offre n’est plus disponible',
                      message:
                          'Retrouvez l’état de vos candidatures dans « Mes candidatures ».',
                      actionLabel: 'Mes candidatures',
                      onAction: () => context.go(WorkerPaths.applications),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _OfferBody extends ConsumerWidget {
  const _OfferBody({required this.application});

  final Application application;

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(applicationActionsProvider.notifier)
        .confirmOffer(application.id);
    if (!context.mounted) return;
    switch (result) {
      case Success(:final value) when value.assignmentId != null:
        context.pushReplacement(WorkerPaths.assignment(value.assignmentId!));
      case Success():
        context.pop();
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  Future<void> _decline(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Décliner cette offre ?'),
        content: const Text('La place sera proposée au candidat suivant.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Garder l’offre'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Décliner l’offre'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final result = await ref
        .read(applicationActionsProvider.notifier)
        .declineOffer(application.id);
    if (!context.mounted) return;
    switch (result) {
      case Success():
        // Le toast vit dans le ScaffoldMessenger racine : il survit au pop.
        showAppToast(context, 'Offre déclinée');
        context.pop();
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)();
    final sending = ref.watch(applicationActionsProvider).isLoading;
    final mission = application.mission;
    final expiresAt = application.offerExpiresAt ?? now;
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
        const SizedBox(height: AppSpacing.md),
        Text(
          'BONNE NOUVELLE',
          style: AppTypography.small.copyWith(
            color: AppColors.ochreDeep,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Vous êtes retenu pour cette mission',
          style: AppTypography.title,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppBanner(
          tone: AppBannerTone.todo,
          title:
              'Confirmez avant ${formatDayRelative(expiresAt, now).toLowerCase()} '
              '${formatHour(expiresAt)},',
          message: 'sinon la place passe au candidat suivant.',
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
              Text(mission.title, style: AppTypography.subtitle),
              const SizedBox(height: 10),
              _Line(
                label: 'Quand',
                value:
                    '${formatDayRelative(mission.startAt, now)} · '
                    '${formatHour(mission.startAt)} · ${formatDuration(mission.duration)}',
              ),
              _Line(label: 'Où', value: mission.city),
              _Line(
                label: 'Annonceur',
                value:
                    '${mission.posterName}'
                    '${mission.posterVerified ? ' · ✓ vérifié' : ''}'
                    ' · ★ ${formatRating(mission.posterRating)}',
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
                formatFcfa(mission.payAmount),
                style: AppTypography.amount.copyWith(
                  color: AppColors.ochreDeep,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const Text(
          'En confirmant, vous recevez l’adresse exacte, l’itinéraire et l’accès à '
          'la messagerie. Un désistement de dernière minute baisse votre score de '
          'fiabilité.',
          style: AppTypography.caption,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Je confirme, j’y serai',
          isLoading: sending,
          onPressed: () => _confirm(context, ref),
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Je ne suis plus disponible',
          variant: AppButtonVariant.destructive,
          onPressed: sending ? null : () => _decline(context, ref),
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 90, child: Text(label, style: AppTypography.caption)),
          Expanded(child: Text(value, style: AppTypography.label)),
        ],
      ),
    );
  }
}
