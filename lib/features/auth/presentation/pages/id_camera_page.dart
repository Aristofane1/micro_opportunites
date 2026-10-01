import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class IdCameraPage extends ConsumerStatefulWidget {
  final bool isFront;

  const IdCameraPage({super.key, required this.isFront});

  @override
  ConsumerState<IdCameraPage> createState() => _IdCameraPageState();
}

class _IdCameraPageState extends ConsumerState<IdCameraPage> {
  bool _busy = false;

  bool get isFront => widget.isFront;

  Future<void> _onShutter() async {
    if (_busy || ref.read(authActionsProvider).isLoading) return;
    _busy = true;
    ref
        .read(entryDraftControllerProvider.notifier)
        .markCaptured(front: isFront);
    if (isFront) {
      await context.push(EntryPaths.cameraBack);
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
                    isFront
                        ? 'Placez le recto dans le cadre'
                        : 'Placez le verso dans le cadre',
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
                    onPressed: () => context.canPop()
                        ? context.pop()
                        : context.go(
                            isFront
                                ? EntryPaths.idDocument
                                : EntryPaths.cameraFront,
                          ),
                  ),
                  Text(
                    isFront ? 'Recto - Etape 1 sur 2' : 'Verso - Etape 2 sur 2',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                  Text(
                    isFront
                        ? 'Photographier le recto'
                        : 'Photographier le verso',
                    style: const TextStyle(color: Colors.white),
                  ),
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
