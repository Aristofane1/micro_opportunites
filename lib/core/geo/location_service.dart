import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

typedef GeoPoint = ({double latitude, double longitude});

/// Port de géolocalisation. Une vraie implémentation (geolocator) ignore
/// [expected] ; le simulateur (`test/support/fake_backend`) s'en sert pour
/// se placer près du lieu.
abstract interface class LocationService {
  Future<GeoPoint> currentPosition({GeoPoint? expected});
}

/// Délai d'obtention d'une position par le GPS.
const locationTimeout = Duration(seconds: 15);

/// Position de l'appareil, ou `null` si elle n'arrive pas dans [timeout]
/// (localisation coupée, permission refusée, pas de position) : l'appelant
/// se replie alors silencieusement sur une autre position.
Future<GeoPoint?> tryCurrentPosition(
  LocationService service, {
  Duration timeout = locationTimeout,
}) async {
  try {
    return await service.currentPosition().timeout(timeout);
  } catch (_) {
    return null;
  }
}

/// À surcharger au démarrage (`app/bootstrap.dart`).
@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => throw UnimplementedError(
  'locationServiceProvider doit être surchargé au démarrage (app/bootstrap.dart).',
);
