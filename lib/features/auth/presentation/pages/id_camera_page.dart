import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/media/photo_picker.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

/// A09 : prise de vue de la pièce (recto, verso sauf passeport) puis selfie,
/// avec le vrai appareil photo. Annuler la prise de vue laisse sur l'étape.
class IdCameraPage extends ConsumerStatefulWidget {
  final KycShot shot;

  const IdCameraPage({super.key, required this.shot});

  @override
  ConsumerState<IdCameraPage> createState() => _IdCameraPageState();
}

class _IdCameraPageState extends ConsumerState<IdCameraPage> {
  bool _busy = false;

  KycShot get shot => widget.shot;

  List<KycShot> get _steps =>
      KycShot.stepsFor(ref.read(entryDraftControllerProvider).documentType);

  static String _pathOf(KycShot shot) => switch (shot) {
    KycShot.front => EntryPaths.cameraFront,
    KycShot.back => EntryPaths.cameraBack,
    KycShot.selfie => EntryPaths.cameraSelfie,
  };

  Future<void> _onShutter() async {
    if (_busy || ref.read(authActionsProvider).isLoading) return;
    _busy = true;
    String? path;
    try {
      path = await ref
          .read(photoPickerProvider)
          .pick(PhotoSource.camera, frontCamera: shot == KycShot.selfie);
    } catch (_) {
      if (mounted) {
        showAppToast(context, 'Impossible d’accéder à l’appareil photo.');
      }
    }
    if (!mounted) return;
    if (path == null) {
      _busy = false;
      return;
    }
    ref.read(entryDraftControllerProvider.notifier).setPhoto(shot, path);
    final steps = _steps;
    final index = steps.indexOf(shot);
    if (index >= 0 && index < steps.length - 1) {
      await context.push(_pathOf(steps[index + 1]));
      // Réarme le déclencheur quand on revient de l'étape suivante.
      if (mounted) _busy = false;
      return;
    }
    final result = await ref.read(authActionsProvider.notifier).submitKyc();
    if (!mounted) return;
    switch (result) {
      case Success():
        context.go(EntryPaths.verificationPending);
      case Err(:final failure):
        _busy = false;
        showAppToast(context, failure.message);
    }
  }

  String get _stepLabel {
    final steps = _steps;
    final name = switch (shot) {
      KycShot.front => 'Recto',
      KycShot.back => 'Verso',
      KycShot.selfie => 'Selfie',
    };
    return '$name - Etape ${steps.indexOf(shot) + 1} sur ${steps.length}';
  }

  void _close() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    final steps = _steps;
    final index = steps.indexOf(shot);
    context.go(index > 0 ? _pathOf(steps[index - 1]) : EntryPaths.idDocument);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Mock Camera View
            Positioned.fill(child: Container(color: Colors.black87)),
            // Guide Frame
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.ochre, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    switch (shot) {
                      KycShot.front => 'Placez le recto dans le cadre',
                      KycShot.back => 'Placez le verso dans le cadre',
                      KycShot.selfie => 'Placez votre visage dans le cadre',
                    },
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),
            ),
            // Header
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _close,
                  ),
                  Expanded(
                    child: Text(
                      _stepLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_off, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Bottom Controls
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(switch (shot) {
                    KycShot.front => 'Photographier le recto',
                    KycShot.back => 'Photographier le verso',
                    KycShot.selfie => 'Prenez un selfie',
                  }, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    key: const Key('camera.shutter'),
                    onTap: _onShutter,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      child: Center(
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
