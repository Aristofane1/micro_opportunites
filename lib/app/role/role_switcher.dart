import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_palette.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

/// Bascule Exécutant / Annonceur (vert / ocre), en haut de chaque écran.
/// Rétrécit plutôt que de déborder sur les petits écrans.
class RoleSwitcher extends ConsumerWidget {
  const RoleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeRoleProvider);
    final palette = context.palette;
    return Semantics(
      container: true,
      label: 'Profil actif',
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.toggleTrack,
            borderRadius: AppRadius.pillAll,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final role in ActiveRole.values)
                  _Segment(
                    role: role,
                    selected: role == active,
                    color: role == ActiveRole.worker
                        ? palette.worker
                        : palette.poster,
                    onTap: () =>
                        ref.read(activeRoleProvider.notifier).switchTo(role),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.role,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final ActiveRole role;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  static const _visualHeight = 38.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      // Le visuel du segment reste à _visualHeight (38 px) ; ce padding
      // porte la zone tactile à AppSizes.minTouchTarget (44 px).
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: (AppSizes.minTouchTarget - _visualHeight) / 2,
          ),
          child: Material(
            color: selected ? color : Colors.transparent,
            shape: const StadiumBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: _visualHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Center(
                    widthFactor: 1,
                    child: Text(
                      role.label,
                      style: AppTypography.label.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? AppColors.white
                            : AppColors.toggleText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
