import 'package:url_launcher/url_launcher.dart';

/// Ouvre l'itinéraire vers le point dans l'app de navigation du téléphone
/// (Google Maps, Plans…). Renvoie `false` si aucune app ne peut l'ouvrir.
Future<bool> openDirections({
  required double latitude,
  required double longitude,
}) {
  final uri = Uri.https('www.google.com', '/maps/dir/', {
    'api': '1',
    'destination': '$latitude,$longitude',
  });
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}
