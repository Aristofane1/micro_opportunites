import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/annonceur/data/models/candidate_model.dart';
import 'package:micro_opportunites/features/annonceur/data/models/poster_mission_model.dart';
import 'package:micro_opportunites/features/annonceur/data/models/wallet_model.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';

/// Position par défaut quand l'épingle n'a pas été posée (Abomey-Calavi).
const _defaultLat = 6.4488;
const _defaultLng = 2.3556;

class AnnonceurRemoteDataSource {
  AnnonceurRemoteDataSource(this._api);

  final ApiClient _api;

  Future<List<PosterMissionModel>> fetchMyMissions() async {
    final json = await _api.get('/me/missions') as List<dynamic>;
    return [
      for (final item in json)
        PosterMissionModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<PosterMissionModel> fetchMission(String id) async =>
      PosterMissionModel.fromJson(
        await _api.get('/me/missions/$id') as Map<String, dynamic>,
      );

  Future<PosterMissionModel> publish(MissionDraft d) async =>
      PosterMissionModel.fromJson(
        await _api.post(
              '/missions',
              body: {
                'title': d.title,
                'category': d.category!.apiValue,
                'description': d.description ?? '',
                'city': d.city,
                'address': d.address,
                'landmark': d.landmark ?? '',
                'lat': d.latitude ?? _defaultLat,
                'lng': d.longitude ?? _defaultLng,
                'startAt': d.startAt!.toUtc().toIso8601String(),
                'durationMin': d.durationMinutes,
                'payAmount': d.payAmount,
                'payUnit': d.payUnit.name,
                'slots': d.slotsTotal,
                'applyDeadline': (d.applyDeadline ?? d.startAt!)
                    .toUtc()
                    .toIso8601String(),
              },
            )
            as Map<String, dynamic>,
      );

  Future<List<CandidateModel>> fetchCandidates(String missionId) async {
    final json =
        await _api.get('/missions/$missionId/candidates') as List<dynamic>;
    return [
      for (final item in json)
        CandidateModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<CandidateModel> offer(String applicationId) =>
      _candidate('/applications/$applicationId/offer');

  Future<CandidateModel> reject(String applicationId) =>
      _candidate('/applications/$applicationId/reject');

  Future<CandidateModel> validate(String assignmentId) =>
      _candidate('/assignments/$assignmentId/validate');

  Future<CandidateModel> contest(String assignmentId, String reason) =>
      _candidate('/assignments/$assignmentId/contest', {'reason': reason});

  Future<PosterMissionModel> cancel(String missionId) async =>
      PosterMissionModel.fromJson(
        await _api.post('/missions/$missionId/cancel') as Map<String, dynamic>,
      );

  Future<WalletModel> fetchWallet() async => WalletModel.fromJson(
    await _api.get('/me/wallet') as Map<String, dynamic>,
  );

  Future<CandidateModel> _candidate(String path, [Object? body]) async =>
      CandidateModel.fromJson(
        await _api.post(path, body: body) as Map<String, dynamic>,
      );
}
