import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_map.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';
import 'package:micro_opportunites/features/missions/domain/entities/poster_profile.dart';

abstract interface class MissionsRepository {
  Future<Result<MissionPage>> fetchMissions(MissionFilters filters);

  Future<Result<MissionMap>> fetchMissionMap();

  Future<Result<Mission>> fetchMission(String id);

  Future<Result<PosterProfile>> fetchPoster(String id);
}
