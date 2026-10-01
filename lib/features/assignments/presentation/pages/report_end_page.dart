import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/media/photo_picker.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/presentation/controllers/assignments_controller.dart';

/// Signaler la fin (B12) : récapitulatif, photos, mot, check-out.
class ReportEndPage extends ConsumerStatefulWidget {
  const ReportEndPage({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  ConsumerState<ReportEndPage> createState() => _ReportEndPageState();
}

class _ReportEndPageState extends ConsumerState<ReportEndPage> {
  static const _maxPhotos = 4;

  final _note = TextEditingController();
  final _photos = <String>[];

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _addPhoto() async {
    final source = await showModalBottomSheet<PhotoSource>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            0,
            AppSpacing.screen,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppListTile(
                leading: const AppIcon(AppIcons.media, color: AppColors.green),
                title: 'Prendre une photo',
                onTap: () => Navigator.of(sheetContext).pop(PhotoSource.camera),
              ),
              const SizedBox(height: AppSpacing.xs),
              AppListTile(
                leading: const AppIcon(AppIcons.media, color: AppColors.green),
                title: 'Choisir dans la galerie',
                onTap: () =>
                    Navigator.of(sheetContext).pop(PhotoSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null || !mounted) return;
    String? path;
    try {
      path = await ref.read(photoPickerProvider).pick(source);
    } catch (_) {
      if (mounted) showAppToast(context, 'Impossible d’accéder aux photos.');
      return;
    }
    if (path != null && mounted) setState(() => _photos.add(path!));
  }

  Future<void> _submit(Assignment assignment) async {
    final result = await ref
        .read(assignmentActionsProvider.notifier)
        .checkOut(
          assignment.id,
          note: _note.text.trim(),
          photos: List.of(_photos),
        );
    if (!mounted) return;
    switch (result) {
      case Success():
        context.pop();
      case Err(:final failure):
        showAppToast(context, failure.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final assignment = ref.watch(assignmentProvider(widget.assignmentId));
    final busy = ref.watch(assignmentActionsProvider).isLoading;
    final now = ref.watch(clockProvider)();
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler la fin')),
      body: AsyncValueView<Assignment>(
        value: assignment,
        onRetry: () => ref.invalidate(assignmentProvider(widget.assignmentId)),
        data: (value) {
          final checkInAt = value.checkInAt ?? now;
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.xs,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border.all(color: AppColors.line),
                  borderRadius: AppRadius.cardAll,
                ),
                child: Column(
                  children: [
                    _SummaryRow(label: 'Arrivée', value: formatHour(checkInAt)),
                    _SummaryRow(
                      label: 'Départ (check-out)',
                      value: formatHour(now),
                    ),
                    _SummaryRow(
                      label: 'Sur place',
                      value: formatDuration(now.difference(checkInAt)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Photos du travail fait (conseillé)',
                style: AppTypography.label,
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final (index, path) in _photos.indexed)
                    _PhotoThumb(
                      path: path,
                      onRemove: () => setState(() => _photos.removeAt(index)),
                    ),
                  if (_photos.length < _maxPhotos)
                    _AddPhotoTile(onTap: _addPhoto),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Elles servent de preuve si l’annonceur conteste.',
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Un mot sur la mission',
                controller: _note,
                maxLines: 3,
                maxLength: 300,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppBanner(
                tone: AppBannerTone.todo,
                message:
                    '${value.posterName} a 48 h pour valider. Sans réponse, '
                    'vous êtes payé automatiquement.',
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: switch (assignment) {
        AsyncData(:final value) => SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              12,
              AppSpacing.screen,
              12,
            ),
            child: AppButton(
              label: 'Envoyer et faire mon check-out',
              isLoading: busy,
              onPressed: () => _submit(value),
            ),
          ),
        ),
        _ => null,
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTypography.caption)),
          Text(value, style: AppTypography.label),
        ],
      ),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 88,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: AppRadius.fieldAll,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: AppColors.ivory,
                  child: Center(
                    child: AppIcon(
                      AppIcons.media,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Semantics(
              button: true,
              label: 'Retirer la photo',
              excludeSemantics: true,
              onTap: onRemove,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onRemove,
                child: SizedBox.square(
                  dimension: 44,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.ink,
                          shape: BoxShape.circle,
                        ),
                        child: const AppIcon(
                          AppIcons.close,
                          size: 14,
                          color: AppColors.white,
                        ),
                      ),
                    ),
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

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.fieldAll,
        side: BorderSide(color: AppColors.lineStrong),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: const SizedBox.square(
          dimension: 88,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(AppIcons.media, size: 22, color: AppColors.green),
              SizedBox(height: 4),
              Text('+ Ajouter', style: AppTypography.small),
            ],
          ),
        ),
      ),
    );
  }
}
