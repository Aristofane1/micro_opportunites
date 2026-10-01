import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/missions/data/missions_providers.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';
import 'package:micro_opportunites/features/missions/domain/entities/poster_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mission_detail_controller.g.dart';

@riverpod
Future<Mission> missionDetail(Ref ref, String id) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(missionsRepositoryProvider).fetchMission(id))
      .getOrThrow();
}

@riverpod
Future<PosterProfile> posterProfile(Ref ref, String id) async =>
    (await ref.watch(missionsRepositoryProvider).fetchPoster(id)).getOrThrow();
