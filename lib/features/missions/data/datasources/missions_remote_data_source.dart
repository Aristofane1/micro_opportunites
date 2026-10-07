import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/missions/data/models/mission_map_model.dart';
import 'package:micro_opportunites/features/missions/data/models/mission_model.dart';
import 'package:micro_opportunites/features/missions/data/models/mission_page_model.dart';
import 'package:micro_opportunites/features/missions/data/models/poster_profile_model.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';

/// Appels REST de la feature missions.
class MissionsRemoteDataSource {
  MissionsRemoteDataSource(
    this._api, {
    Future<GeoPoint?> Function()? devicePosition,
  }) : _devicePosition = devicePosition ?? _noPosition;

  final ApiClient _api;

  /// Position de l'appareil pour le rayon d'Explorer ; `null` : le serveur
  /// prend celle du profil.
  final Future<GeoPoint?> Function() _devicePosition;

  static Future<GeoPoint?> _noPosition() async => null;

  Future<MissionPageModel> fetchMissions(MissionFilters filters) async {
    final query = filters.query?.trim();
    // Une ville choisie remplace le rayon : la position est inutile.
    final position = filters.city == null ? await _devicePosition() : null;
    final json = await _api.get(
      '/missions',
      query: {
        'km': '${filters.radiusKm}',
        if (filters.categories.isNotEmpty)
          'cat': filters.categories.map((c) => c.apiValue).join(','),
        if (filters.minPay != null) 'min': '${filters.minPay}',
        'when': filters.period.apiValue,
        if (filters.multiSlotsOnly) 'multi': 'true',
        if (filters.city != null) 'city': filters.city!,
        if (query != null && query.isNotEmpty) 'q': query,
        if (position != null) ...{
          'lat': '${position.latitude}',
          'lng': '${position.longitude}',
        },
      },
    );
    return MissionPageModel.fromJson(json! as Map<String, dynamic>);
  }

  Future<MissionMapModel> fetchMissionMap() async => MissionMapModel.fromJson(
    await _api.get('/missions/cities') as Map<String, dynamic>,
  );

  Future<MissionModel> fetchMission(String id) async => MissionModel.fromJson(
    await _api.get('/missions/$id') as Map<String, dynamic>,
  );

  Future<PosterProfileModel> fetchPoster(String id) async =>
      PosterProfileModel.fromJson(
        await _api.get('/posters/$id') as Map<String, dynamic>,
      );
}
