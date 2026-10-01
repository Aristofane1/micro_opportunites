import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/missions/data/datasources/missions_remote_data_source.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_map.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';
import 'package:micro_opportunites/features/missions/domain/entities/poster_profile.dart';
import 'package:micro_opportunites/features/missions/domain/repositories/missions_repository.dart';

class MissionsRepositoryImpl implements MissionsRepository {
  MissionsRepositoryImpl(this._remote);

  final MissionsRemoteDataSource _remote;

  @override
  Future<Result<MissionPage>> fetchMissions(MissionFilters filters) =>
      guardResult(
        () async => (await _remote.fetchMissions(filters)).toEntity(),
      );

  @override
  Future<Result<MissionMap>> fetchMissionMap() =>
      guardResult(() async => (await _remote.fetchMissionMap()).toEntity());

  @override
  Future<Result<Mission>> fetchMission(String id) =>
      guardResult(() async => (await _remote.fetchMission(id)).toEntity());

  @override
  Future<Result<PosterProfile>> fetchPoster(String id) =>
      guardResult(() async => (await _remote.fetchPoster(id)).toEntity());
}
