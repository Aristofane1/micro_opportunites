/// Table de correspondance entre les routes REST de l'app et les fonctions
/// SQL (RPC) Supabase. Une entrée par route du contrat d'API, sauf
/// `/auth/login`, `/auth/signup` et `/auth/logout`, traitées par Supabase Auth.
library;

typedef Params = Map<String, String>;
typedef Query = Map<String, String>;
typedef Body = Map<String, Object?>;

/// Arguments nommés de la RPC, construits à partir de la requête REST.
typedef RpcArgs =
    Map<String, Object?> Function(Params params, Query query, Body body);

typedef SupabaseRoute = ({
  String method,
  String pattern,
  String? rpc,
  RpcArgs args,
});

Map<String, Object?> _none(Params p, Query q, Body b) => const {};

Map<String, Object?> _id(Params p, Query q, Body b) => {'id': p['id']};

Map<String, Object?> _missionId(Params p, Query q, Body b) => {
  'mission_id': p['id'],
};

Map<String, Object?> _saveProfile(Params p, Query q, Body b) => {
  'first_name': b['firstName'],
  'last_name': b['lastName'],
  'birth_date': b['birthDate'],
  'accept_terms': b['acceptTerms'],
  'accept_newsletter': b['acceptNewsletter'],
};

Map<String, Object?> _submitKyc(Params p, Query q, Body b) => {
  'document_type': b['documentType'],
  'country_code': b['countryCode'],
  'front_path': b['frontPath'],
  'back_path': b['backPath'],
  'selfie_path': b['selfiePath'],
};

Map<String, Object?> _setRole(Params p, Query q, Body b) => {'role': b['role']};

/// Filtres d'Explorer : `km` et `min` en entiers, `multi` en booléen, comme
/// le lit le serveur ; les autres tels quels. La position de l'appareil
/// (`lat`, `lng` en réels) n'est transmise que complète.
Map<String, Object?> _listMissions(Params p, Query q, Body b) {
  final lat = double.tryParse(q['lat'] ?? '');
  final lng = double.tryParse(q['lng'] ?? '');
  return {
    'km': int.tryParse(q['km'] ?? ''),
    'cat': q['cat'],
    'min': int.tryParse(q['min'] ?? ''),
    'when': q['when'],
    'multi': q['multi'] == null ? null : q['multi'] == 'true',
    'city': q['city'],
    'q': q['q'],
    if (lat != null && lng != null) ...{'lat': lat, 'lng': lng},
  };
}

Map<String, Object?> _publish(Params p, Query q, Body b) => {'body': b};

Map<String, Object?> _apply(Params p, Query q, Body b) => {
  'mission_id': p['id'],
  'message': b['message'],
};

Map<String, Object?> _checkIn(Params p, Query q, Body b) => {
  'id': p['id'],
  'lat': b['lat'],
  'lng': b['lng'],
};

Map<String, Object?> _checkOut(Params p, Query q, Body b) => {
  'id': p['id'],
  'note': b['note'],
  'photos': b['photos'],
};

Map<String, Object?> _contest(Params p, Query q, Body b) => {
  'id': p['id'],
  'reason': b['reason'],
};

Map<String, Object?> _createAlert(Params p, Query q, Body b) => {
  'keyword': b['keyword'],
  'category': b['category'],
  'zone': b['zone'],
  'min_pay': b['minPay'],
  'days': b['days'],
};

/// Même ordre que le faux serveur : un chemin fixe (`/missions/cities`)
/// passe avant le chemin paramétré qui l'engloberait (`/missions/:id`).
const supabaseRoutes = <SupabaseRoute>[
  (
    method: 'POST',
    pattern: '/auth/profile',
    rpc: 'save_profile',
    args: _saveProfile,
  ),
  (method: 'POST', pattern: '/auth/kyc', rpc: 'submit_kyc', args: _submitKyc),
  (method: 'GET', pattern: '/auth/kyc', rpc: 'get_kyc', args: _none),
  (method: 'POST', pattern: '/me/role', rpc: 'set_role', args: _setRole),
  (method: 'GET', pattern: '/me', rpc: 'me', args: _none),
  (
    method: 'GET',
    pattern: '/me/missions',
    rpc: 'list_my_missions',
    args: _none,
  ),
  (
    method: 'GET',
    pattern: '/me/missions/:id',
    rpc: 'get_my_mission',
    args: _id,
  ),
  (method: 'GET', pattern: '/me/wallet', rpc: 'get_wallet', args: _none),
  (
    method: 'GET',
    pattern: '/missions',
    rpc: 'list_missions',
    args: _listMissions,
  ),
  (method: 'GET', pattern: '/missions/cities', rpc: 'list_cities', args: _none),
  (method: 'GET', pattern: '/missions/:id', rpc: 'get_mission', args: _id),
  (
    method: 'GET',
    pattern: '/missions/:id/candidates',
    rpc: 'list_candidates',
    args: _missionId,
  ),
  (method: 'GET', pattern: '/posters/:id', rpc: 'get_poster', args: _id),
  (
    method: 'POST',
    pattern: '/missions',
    rpc: 'publish_mission',
    args: _publish,
  ),
  (
    method: 'POST',
    pattern: '/missions/:id/cancel',
    rpc: 'cancel_mission',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/missions/:id/applications',
    rpc: 'apply_to_mission',
    args: _apply,
  ),
  (
    method: 'GET',
    pattern: '/me/applications',
    rpc: 'list_my_applications',
    args: _none,
  ),
  (
    method: 'POST',
    pattern: '/applications/:id/withdraw',
    rpc: 'withdraw_application',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/applications/:id/confirm',
    rpc: 'confirm_offer',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/applications/:id/decline',
    rpc: 'decline_offer',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/applications/:id/offer',
    rpc: 'offer_application',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/applications/:id/reject',
    rpc: 'reject_application',
    args: _id,
  ),
  (
    method: 'GET',
    pattern: '/assignments/:id',
    rpc: 'get_assignment',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/assignments/:id/check-in',
    rpc: 'check_in',
    args: _checkIn,
  ),
  (
    method: 'POST',
    pattern: '/assignments/:id/check-out',
    rpc: 'check_out',
    args: _checkOut,
  ),
  (
    method: 'POST',
    pattern: '/assignments/:id/withdraw',
    rpc: 'withdraw_assignment',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/assignments/:id/validate',
    rpc: 'validate_assignment',
    args: _id,
  ),
  (
    method: 'POST',
    pattern: '/assignments/:id/contest',
    rpc: 'contest_assignment',
    args: _contest,
  ),
  (method: 'GET', pattern: '/me/earnings', rpc: 'get_earnings', args: _none),
  (method: 'GET', pattern: '/me/payouts/:id', rpc: 'get_payout', args: _id),
  (method: 'GET', pattern: '/me/alerts', rpc: 'list_alerts', args: _none),
  (
    method: 'POST',
    pattern: '/me/alerts',
    rpc: 'create_alert',
    args: _createAlert,
  ),
  (method: 'DELETE', pattern: '/me/alerts/:id', rpc: 'delete_alert', args: _id),
];

/// Première route de [supabaseRoutes] qui correspond (segment par segment,
/// `:param` capturant un segment), avec ses paramètres de chemin.
({SupabaseRoute route, Map<String, String> params})? matchRoute(
  String method,
  String path,
) {
  final segments = _segments(path);
  for (final route in supabaseRoutes) {
    if (route.method != method) continue;
    final pattern = _segments(route.pattern);
    if (pattern.length != segments.length) continue;
    final params = <String, String>{};
    var matches = true;
    for (var i = 0; i < segments.length; i++) {
      if (pattern[i].startsWith(':')) {
        params[pattern[i].substring(1)] = segments[i];
      } else if (pattern[i] != segments[i]) {
        matches = false;
        break;
      }
    }
    if (matches) return (route: route, params: params);
  }
  return null;
}

List<String> _segments(String path) =>
    path.split('/').where((s) => s.isNotEmpty).toList();
