import 'dart:convert';

import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'fake_database.dart';
import 'fake_routing.dart';
import 'handlers/alerts_handlers.dart';
import 'handlers/applications_handlers.dart';
import 'handlers/assignments_handlers.dart';
import 'handlers/auth_handlers.dart';
import 'handlers/earnings_handlers.dart';
import 'handlers/me_handlers.dart';
import 'handlers/missions_handlers.dart';
import 'handlers/poster_handlers.dart';
import 'settlement.dart';

/// Faux serveur REST en mémoire : mêmes routes et même JSON que la future
/// API. Les requêtes et réponses passent par `jsonEncode`/`jsonDecode`
/// pour se comporter comme un vrai transport.
class FakeApiClient implements ApiClient {
  FakeApiClient(
    this.db, {
    required this.clock,
    this.latency = const Duration(milliseconds: 400),
  });

  final FakeDatabase db;
  final DateTime Function() clock;
  final Duration latency;

  /// Erreur levée par la prochaine requête puis oubliée (tests, démos).
  ApiException? nextError;

  /// Si renseigné, [nextError] ne vise que la prochaine requête sur ce
  /// chemin exact (les autres passent normalement).
  String? nextErrorPath;

  static final List<FakeRoute> _routes = [
    FakeRoute('POST', '/auth/login', login),
    FakeRoute('POST', '/auth/signup', signup),
    FakeRoute('POST', '/auth/logout', logout),
    FakeRoute('POST', '/auth/profile', saveProfile),
    FakeRoute('POST', '/auth/kyc', submitKyc),
    FakeRoute('GET', '/auth/kyc', getKyc),
    FakeRoute('POST', '/me/role', setRole),
    FakeRoute('GET', '/me', getMe),
    FakeRoute('GET', '/me/missions', listMyMissions),
    FakeRoute('GET', '/me/missions/:id', getMyMission),
    FakeRoute('GET', '/me/wallet', getWallet),
    FakeRoute('GET', '/missions', listMissions),
    FakeRoute('GET', '/missions/cities', listCities),
    FakeRoute('GET', '/missions/:id', getMission),
    FakeRoute('GET', '/missions/:id/candidates', listCandidates),
    FakeRoute('GET', '/posters/:id', getPoster),
    FakeRoute('POST', '/missions', publishMission),
    FakeRoute('POST', '/missions/:id/cancel', cancelMission),
    FakeRoute('POST', '/missions/:id/applications', applyToMission),
    FakeRoute('GET', '/me/applications', listMyApplications),
    FakeRoute('POST', '/applications/:id/withdraw', withdrawApplication),
    FakeRoute('POST', '/applications/:id/confirm', confirmOffer),
    FakeRoute('POST', '/applications/:id/decline', declineOffer),
    FakeRoute('POST', '/applications/:id/offer', offerApplication),
    FakeRoute('POST', '/applications/:id/reject', rejectApplication),
    FakeRoute('GET', '/assignments/:id', getAssignment),
    FakeRoute('POST', '/assignments/:id/check-in', checkIn),
    FakeRoute('POST', '/assignments/:id/check-out', checkOut),
    FakeRoute('POST', '/assignments/:id/withdraw', withdrawFromAssignment),
    FakeRoute('POST', '/assignments/:id/validate', validateAssignment),
    FakeRoute('POST', '/assignments/:id/contest', contestAssignment),
    FakeRoute('GET', '/me/earnings', getEarnings),
    FakeRoute('GET', '/me/payouts/:id', getPayout),
    FakeRoute('GET', '/me/alerts', listAlerts),
    FakeRoute('POST', '/me/alerts', createAlert),
    FakeRoute('DELETE', '/me/alerts/:id', deleteAlert),
  ];

  /// Méthode et motif de chaque route, pour vérifier les autres adaptateurs.
  static List<(String, String)> get routeSignatures => [
    for (final r in _routes) (r.method, r.pattern),
  ];

  @override
  Future<Object?> get(String path, {Map<String, String>? query}) =>
      _send('GET', path, query: query);

  @override
  Future<Object?> post(String path, {Object? body}) =>
      _send('POST', path, body: body);

  @override
  Future<Object?> delete(String path) => _send('DELETE', path);

  Future<Object?> _send(
    String method,
    String path, {
    Map<String, String>? query,
    Object? body,
  }) async {
    await Future<void>.delayed(latency);
    settle(db, clock());
    final error = nextError;
    if (error != null && (nextErrorPath == null || nextErrorPath == path)) {
      nextError = null;
      nextErrorPath = null;
      throw error;
    }
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    for (final route in _routes) {
      if (route.method != method) continue;
      final params = route.match(segments);
      if (params == null) continue;
      final decodedBody = body == null
          ? const <String, dynamic>{}
          : jsonDecode(jsonEncode(body)) as Map<String, dynamic>;
      final result = route.handler(
        db,
        FakeRequest(
          params: params,
          query: query ?? const {},
          body: decodedBody,
          now: clock(),
        ),
      );
      return result == null ? null : jsonDecode(jsonEncode(result));
    }
    throw ApiException(404, 'Route inconnue : $method $path');
  }
}
