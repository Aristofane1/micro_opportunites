import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/geo/directions.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_map.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/presentation/controllers/assignments_controller.dart';

/// Mission confirmée (B10) : adresse, carte, itinéraire, check-in.
class ConfirmedView extends ConsumerStatefulWidget {
  const ConfirmedView({super.key, required this.assignment});

  final Assignment assignment;

  @override
  ConsumerState<ConfirmedView> createState() => _ConfirmedViewState();
}

class _ConfirmedViewState extends ConsumerState<ConfirmedView> {
  bool _sharePosition = false;

  Assignment get _assignment => widget.assignment;

  Future<void> _directions() async {
    var opened = false;
    try {
      opened = await openDirections(
        latitude: _assignment.latitude,
        longitude: _assignment.longitude,
      );
    } catch (_) {
      opened = false;
    }
    if (!opened && mounted) {
      showAppToast(
        context,
        'Impossible d’ouvrir l’itinéraire sur ce téléphone.',
      );
    }
  }

  Future<void> _checkIn() async {
    final result = await ref
        .read(assignmentActionsProvider.notifier)
        .checkIn(_assignment);
    if (!mounted) return;
    if (result case Err(:final failure)) showAppToast(context, failure.message);
  }

  Future<void> _withdraw() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Se désister de la mission ?'),
        content: const Text(
          'Un désistement de dernière minute baisse votre score de fiabilité.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Rester inscrit'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Me désister'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final result = await ref
        .read(assignmentActionsProvider.notifier)
        .withdraw(_assignment.id);
    if (!mounted) return;
    switch (result) {
      case Success():
        showAppToast(context, 'Vous vous êtes désisté');
        context.go(WorkerPaths.applications);
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = ref.watch(clockProvider)();
    final busy = ref.watch(assignmentActionsProvider).isLoading;
    final topInset = MediaQuery.paddingOf(context).top;
    final place = LatLng(_assignment.latitude, _assignment.longitude);
    final distance = _assignment.distanceKm
        .toStringAsFixed(1)
        .replaceAll('.', ',');

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 300 + topInset,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppMap(
                  center: place,
                  zoom: 15,
                  markers: [
                    Marker(
                      point: place,
                      width: 48,
                      height: 48,
                      child: Semantics(
                        label: 'Lieu de la mission',
                        child: const AppIcon(
                          AppIcons.location,
                          size: 44,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: topInset + AppSpacing.xs,
                left: AppSpacing.md,
                child: RoundIconButton(
                  icon: AppIcons.back,
                  semanticLabel: 'Retour',
                  onPressed: () => context.pop(),
                ),
              ),
              Positioned(
                top: topInset + AppSpacing.md,
                right: AppSpacing.md,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.card,
                    borderRadius: AppRadius.pillAll,
                  ),
                  child: Text(
                    '$distance km · ${_assignment.travelMinutes} min',
                    style: AppTypography.small.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  StatusBadge(
                    MissionStatusKind.confirmed,
                    label:
                        'Confirmée · ${formatDayRelative(_assignment.startAt, now).toLowerCase()} '
                        '${formatHour(_assignment.startAt)}',
                  ),
                  Text(
                    '${formatFcfa(_assignment.payAmount)} réservés',
                    style: AppTypography.label.copyWith(color: AppColors.green),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(_assignment.title, style: AppTypography.subtitle),
              const SizedBox(height: AppSpacing.xs),
              Text(_assignment.address, style: AppTypography.bodyStrong),
              const SizedBox(height: 4),
              Text(
                'Repère : ${_assignment.landmark}',
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Itinéraire',
                      icon: AppIcons.map,
                      variant: AppButtonVariant.secondary,
                      onPressed: _directions,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'Message',
                      icon: AppIcons.messages,
                      variant: AppButtonVariant.secondary,
                      onPressed: () => showComingSoon(context, 'Messagerie'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              MergeSemantics(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Partager ma position en route',
                        style: AppTypography.label,
                      ),
                    ),
                    Switch(
                      value: _sharePosition,
                      onChanged: (value) =>
                          setState(() => _sharePosition = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Je suis arrivé',
                icon: AppIcons.locationCheck,
                isLoading: busy,
                onPressed: _checkIn,
              ),
              const SizedBox(height: 6),
              Text(
                'Possible à moins de 200 m, dès '
                '${formatHour(_assignment.startAt.subtract(const Duration(minutes: 30)))}',
                textAlign: TextAlign.center,
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.xs),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: AppColors.red),
                  onPressed: busy ? null : _withdraw,
                  child: const Text('Me désister'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
