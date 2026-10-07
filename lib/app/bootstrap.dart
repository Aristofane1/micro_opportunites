import 'package:flutter_riverpod/misc.dart';
import 'package:micro_opportunites/core/geo/geolocator_location_service.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/geo/map_tiles.dart';

/// Adaptateurs de l'app. Le fournisseur de données (Supabase) est branché
/// par `supabaseOverrides(client)` (app/backend) ; ici, seulement le GPS réel et
/// les tuiles de carte.
List<Override> appOverrides({bool mapTiles = true}) => [
  locationServiceProvider.overrideWithValue(const GeolocatorLocationService()),
  if (!mapTiles) mapTilesEnabledProvider.overrideWithValue(false),
];
