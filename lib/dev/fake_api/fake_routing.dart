import 'package:micro_opportunites/dev/fake_api/fake_database.dart';

/// Requête reçue par un handler du faux serveur.
class FakeRequest {
  const FakeRequest({
    required this.params,
    required this.query,
    required this.body,
    required this.now,
  });

  final Map<String, String> params;
  final Map<String, String> query;
  final Json body;
  final DateTime now;
}

typedef FakeHandler = Object? Function(FakeDatabase db, FakeRequest request);

/// Route « METHODE /chemin/:param ».
class FakeRoute {
  FakeRoute(this.method, String pattern, this.handler)
    : _segments = pattern.split('/').where((s) => s.isNotEmpty).toList();

  final String method;
  final List<String> _segments;
  final FakeHandler handler;

  /// Paramètres extraits si [segments] correspond, sinon `null`.
  Map<String, String>? match(List<String> segments) {
    if (segments.length != _segments.length) return null;
    final params = <String, String>{};
    for (var i = 0; i < segments.length; i++) {
      final pattern = _segments[i];
      if (pattern.startsWith(':')) {
        params[pattern.substring(1)] = segments[i];
      } else if (pattern != segments[i]) {
        return null;
      }
    }
    return params;
  }
}
