import 'package:geolocator/geolocator.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';

/// Position réelle du téléphone. [expected] est ignoré.
class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  static const _disabled = ValidationFailure(
    'Activez la localisation pour faire le check-in.',
  );

  @override
  Future<GeoPoint> currentPosition({GeoPoint? expected}) async {
    if (!await Geolocator.isLocationServiceEnabled()) throw _disabled;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw _disabled;
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: locationTimeout,
      ),
    );
    return (latitude: position.latitude, longitude: position.longitude);
  }
}
