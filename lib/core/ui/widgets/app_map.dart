import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:micro_opportunites/core/geo/map_tiles.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

/// Carte du design : tuiles OSM (si activées) + marqueurs fournis.
class AppMap extends ConsumerWidget {
  const AppMap({
    super.key,
    required this.center,
    this.zoom = 13,
    this.markers = const [],
  });

  final LatLng center;
  final double zoom;
  final List<Marker> markers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tilesEnabled = ref.watch(mapTilesEnabledProvider);
    return ColoredBox(
      color: AppColors.mapLand,
      child: FlutterMap(
        options: MapOptions(initialCenter: center, initialZoom: zoom),
        children: [
          if (tilesEnabled)
            TileLayer(
              urlTemplate: MapTiles.urlTemplate,
              userAgentPackageName: MapTiles.userAgentPackageName,
            ),
          MarkerLayer(markers: markers),
          if (tilesEnabled)
            const SimpleAttributionWidget(source: Text(MapTiles.attribution)),
        ],
      ),
    );
  }
}
