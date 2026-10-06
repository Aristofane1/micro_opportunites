import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/presentation/controllers/assignments_controller.dart';
import 'package:micro_opportunites/features/assignments/presentation/widgets/awaiting_validation_view.dart';
import 'package:micro_opportunites/features/assignments/presentation/widgets/confirmed_view.dart';
import 'package:micro_opportunites/features/assignments/presentation/widgets/in_progress_view.dart';

/// Une mission confirmée : l'écran affiché suit son statut (B10, B11, B13).
class AssignmentPage extends ConsumerWidget {
  const AssignmentPage({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignment = ref.watch(assignmentProvider(assignmentId));
    final Widget body = AsyncValueView<Assignment>(
      value: assignment,
      onRetry: () => ref.invalidate(assignmentProvider(assignmentId)),
      data: (value) => switch (value.status) {
        AssignmentStatus.confirmed => ConfirmedView(assignment: value),
        AssignmentStatus.inProgress => InProgressView(assignment: value),
        AssignmentStatus.submitted ||
        AssignmentStatus.contested ||
        AssignmentStatus.paid => AwaitingValidationView(assignment: value),
        AssignmentStatus.cancelled => Padding(
          padding: const EdgeInsets.all(AppSpacing.screen),
          child: EmptyState(
            title: value.cancelledByPoster
                ? 'Mission annulée par l’annonceur'
                : 'Vous vous êtes désisté de cette mission',
            actionLabel: 'Mes candidatures',
            onAction: () => context.go(WorkerPaths.applications),
          ),
        ),
      },
    );
    return Scaffold(
      appBar: assignment.hasValue ? null : AppBar(),
      // La vue « confirmée » dessine sa carte sous la barre d'état.
      body: assignment.value?.status == AssignmentStatus.confirmed
          ? body
          : SafeArea(child: body),
    );
  }
}
