import 'package:micro_opportunites/core/network/api_exception.dart';
import '../fake_database.dart';
import '../fake_routing.dart';
import '../geo.dart';
import '../serializers.dart';

const _categoryLabels = {
  'event': 'événement',
  'delivery': 'livraison',
  'shopping': 'courses',
  'computer': 'informatique',
  'data_entry': 'saisie de données',
  'cleaning': 'nettoyage',
  'repair': 'réparation',
  'flyers': 'flyers',
  'other': 'autre',
};

const _cityCenters = {
  'Abomey-Calavi': (6.4600, 2.3400),
  'Cotonou': (6.3703, 2.3912),
  'Ouidah': (6.3667, 2.0850),
};

/// Mission ouverte aux candidatures : publiée, pas encore complète, avant
/// la date limite de candidature.
bool _open(Json mission, DateTime now) =>
    mission['status'] == 'published' &&
    (mission['slotsFree'] as int) > 0 &&
    DateTime.parse(mission['applyDeadline'] as String).isAfter(now);

DateTime _beninDay(DateTime instant) {
  final local = instant.toUtc().add(const Duration(hours: 1));
  return DateTime.utc(local.year, local.month, local.day);
}

Object? listMissions(FakeDatabase db, FakeRequest request) {
  final user = db.currentUser;
  final userId = user['id'];
  final query = request.query;
  final km = int.tryParse(query['km'] ?? '') ?? 5;
  final categories = (query['cat'] ?? '')
      .split(',')
      .where((c) => c.isNotEmpty)
      .toSet();
  final minPay = int.tryParse(query['min'] ?? '');
  final when = query['when'] ?? 'all';
  final multiOnly = query['multi'] == 'true';
  final city = query['city'];
  final text = query['q']?.trim().toLowerCase();
  // Position de l'appareil si elle est donnée (les deux), sinon le profil.
  final deviceLat = double.tryParse(query['lat'] ?? '');
  final deviceLng = double.tryParse(query['lng'] ?? '');
  final device = deviceLat != null && deviceLng != null;
  final fromLat = device ? deviceLat : asDouble(user['lat']);
  final fromLng = device ? deviceLng : asDouble(user['lng']);

  final items =
      db.missions.values.where((m) {
        if (!_open(m, request.now) || m['posterId'] == userId) return false;
        if (city != null) {
          if (m['city'] != city) return false;
        } else {
          final zone = m['zone'] as Json;
          final distance = distanceKm(
            fromLat,
            fromLng,
            asDouble(zone['lat']),
            asDouble(zone['lng']),
          );
          if (distance > km) return false;
        }
        if (categories.isNotEmpty && !categories.contains(m['category'])) {
          return false;
        }
        if (minPay != null && workerPay(m) < minPay) {
          return false;
        }
        final start = DateTime.parse(m['startAt'] as String);
        final days = _beninDay(start).difference(_beninDay(request.now)).inDays;
        if (when == 'today' && days != 0) return false;
        if (when == 'week' && days > 6) return false;
        if (multiOnly && (m['slotsTotal'] as int) < 2) return false;
        if (text != null && text.isNotEmpty) {
          final haystack =
              '${m['title']} ${m['description']} ${_categoryLabels[m['category']]}'
                  .toLowerCase();
          if (!haystack.contains(text)) return false;
        }
        return true;
      }).toList()..sort(
        (a, b) =>
            (b['publishedAt'] as String).compareTo(a['publishedAt'] as String),
      );

  return {
    'items': [for (final m in items) publicMission(db, m)],
    'total': items.length,
    'radiusKm': km,
    'updatedAt': request.now
        .toUtc()
        .subtract(const Duration(minutes: 2))
        .toIso8601String(),
  };
}

Object? listCities(FakeDatabase db, FakeRequest request) {
  final byCity = <String, List<Json>>{};
  final userId = db.currentUserId;
  for (final m in db.missions.values.where(
    (m) => _open(m, request.now) && m['posterId'] != userId,
  )) {
    byCity.putIfAbsent(m['city'] as String, () => []).add(m);
  }
  final user = db.currentUser;
  return {
    'userLat': user['lat'],
    'userLng': user['lng'],
    'items': [
      for (final entry in byCity.entries)
        {
          'city': entry.key,
          'count': entry.value.length,
          'lat': _cityCenters[entry.key]?.$1 ?? asDouble(user['lat']),
          'lng': _cityCenters[entry.key]?.$2 ?? asDouble(user['lng']),
          'minPay': entry.value.map(workerPay).reduce((a, b) => a < b ? a : b),
          'maxPay': entry.value.map(workerPay).reduce((a, b) => a > b ? a : b),
        },
    ]..sort((a, b) => (b['count'] as int).compareTo(a['count'] as int)),
  };
}

Object? getMission(FakeDatabase db, FakeRequest request) {
  final mission = db.missions[request.params['id']];
  if (mission == null) throw const ApiException(404, 'Mission introuvable.');
  return publicMission(db, mission);
}

Object? getPoster(FakeDatabase db, FakeRequest request) {
  final poster = db.posters[request.params['id']];
  if (poster == null) throw const ApiException(404, 'Annonceur introuvable.');
  return poster;
}
