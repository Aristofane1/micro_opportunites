import 'package:flutter_riverpod/misc.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/geo/map_tiles.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/dev/fake_api/seed.dart';
import 'package:micro_opportunites/dev/simulation/simulated_location_service.dart';

/// Branche les adaptateurs de l'app. Aujourd'hui le faux serveur ; pour
/// la vraie API, remplacer `FakeApiClient(...)` par le client HTTP.
List<Override> appOverrides({
  Duration latency = const Duration(milliseconds: 400),
  DateTime Function() clock = DateTime.now,
  bool mapTiles = true,
}) {
  return [
    clockProvider.overrideWithValue(clock),
    apiClientProvider.overrideWith(
      (ref) =>
          FakeApiClient(seedDatabase(clock()), clock: clock, latency: latency),
    ),
    locationServiceProvider.overrideWithValue(const SimulatedLocationService()),
    if (!mapTiles) mapTilesEnabledProvider.overrideWithValue(false),
  ];
}
