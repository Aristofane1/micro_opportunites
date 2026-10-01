import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_map.dart';
import 'package:micro_opportunites/core/ui/widgets/async_value_view.dart';
import 'package:micro_opportunites/core/ui/widgets/coming_soon.dart';
import 'package:micro_opportunites/core/ui/widgets/round_icon_button.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_map.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';

/// Explorer sur la carte (B02) : une pastille par ville, jamais d'adresse.
class MissionsMapPage extends ConsumerStatefulWidget {
  const MissionsMapPage({super.key});

  @override
  ConsumerState<MissionsMapPage> createState() => _MissionsMapPageState();
}

class _MissionsMapPageState extends ConsumerState<MissionsMapPage> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return AsyncValueView<MissionMap>(
      value: ref.watch(missionMapProvider),
      onRetry: () => ref.invalidate(missionMapProvider),
      data: (map) {
        final selected = map.clusters
            .where(
              (c) =>
                  c.city == (_selectedCity ?? map.clusters.firstOrNull?.city),
            )
            .firstOrNull;
        return Stack(
          children: [
            Positioned.fill(
              child: AppMap(
                center: LatLng(map.userLatitude, map.userLongitude),
                zoom: 10,
                markers: [
                  for (final cluster in map.clusters)
                    Marker(
                      point: LatLng(cluster.latitude, cluster.longitude),
                      width: 120,
                      height: 100,
                      child: _CityBubble(
                        cluster: cluster,
                        selected: cluster == selected,
                        onTap: () =>
                            setState(() => _selectedCity = cluster.city),
                      ),
                    ),
                  Marker(
                    point: LatLng(map.userLatitude, map.userLongitude),
                    width: 22,
                    height: 22,
                    child: Semantics(
                      label: 'Votre position',
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.card, width: 3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: AppSpacing.sm,
              left: AppSpacing.screen,
              right: AppSpacing.screen,
              child: Row(
                children: [
                  RoundIconButton(
                    icon: AppIcons.list,
                    semanticLabel: 'Retour à la liste',
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Material(
                      color: AppColors.card,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.tileAll,
                        side: BorderSide(color: AppColors.line),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () =>
                            showComingSoon(context, 'Recherche de zone'),
                        child: const SizedBox(
                          height: AppSizes.minTouchTarget,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Rechercher une zone…',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.caption,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selected != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _CityPanel(
                  cluster: selected,
                  onShow: () {
                    ref
                        .read(missionFiltersControllerProvider.notifier)
                        .setCity(selected.city);
                    context.pop();
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CityBubble extends StatelessWidget {
  const _CityBubble({
    required this.cluster,
    required this.selected,
    required this.onTap,
  });

  final CityCluster cluster;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = (40 + cluster.count * 3).clamp(44, 64).toDouble();
    return Semantics(
      button: true,
      selected: selected,
      label: '${cluster.city}, ${cluster.count} missions',
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.green : AppColors.card,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.card : AppColors.green,
                  width: selected ? 4 : 3,
                ),
              ),
              child: Text(
                '${cluster.count}',
                style: AppTypography.headingSmall.copyWith(
                  fontSize: size / 3,
                  color: selected ? AppColors.white : AppColors.green,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                cluster.city,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.small.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CityPanel extends StatelessWidget {
  const _CityPanel({required this.cluster, required this.onShow});

  final CityCluster cluster;
  final VoidCallback onShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        12,
        AppSpacing.screen,
        18,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.sheet),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.lineStrong,
                borderRadius: AppRadius.pillAll,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${cluster.city} · ${cluster.count} missions',
            style: AppTypography.subtitle,
          ),
          Text(
            'de ${formatAmount(cluster.minPay)} à ${formatFcfa(cluster.maxPay)}',
            style: AppTypography.caption,
          ),
          const SizedBox(height: 6),
          const Text(
            'La carte montre des villes, jamais d’adresses : le lieu exact '
            's’affiche quand vous êtes retenu.',
            style: AppTypography.caption,
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Voir les ${cluster.count} missions',
            onPressed: onShow,
          ),
        ],
      ),
    );
  }
}
