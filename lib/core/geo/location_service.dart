import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

typedef GeoPoint = ({double latitude, double longitude});

/// Port de géolocalisation. Une vraie implémentation (geolocator) ignore
/// [expected] ; le simulateur (`lib/dev`) s'en sert pour se placer près du lieu.
abstract interface class LocationService {
  Future<GeoPoint> currentPosition({GeoPoint? expected});
}

/// À surcharger au démarrage (`app/bootstrap.dart`).
@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => throw UnimplementedError(
  'locationServiceProvider doit être surchargé au démarrage (app/bootstrap.dart).',
);
