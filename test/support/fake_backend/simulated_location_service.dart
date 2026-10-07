import 'package:micro_opportunites/core/geo/location_service.dart';

/// Position simulée : ~40 m au nord du lieu attendu, sinon Abomey-Calavi.
class SimulatedLocationService implements LocationService {
  const SimulatedLocationService();

  @override
  Future<GeoPoint> currentPosition({GeoPoint? expected}) async {
    if (expected != null) {
      return (
        latitude: expected.latitude + 0.00036,
        longitude: expected.longitude,
      );
    }
    return (latitude: 6.4485, longitude: 2.3557);
  }
}
