import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/missions/data/missions_providers.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_map.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_controller.g.dart';

/// Liste d'Explorer (B01) selon les filtres courants.
@riverpod
Future<MissionPage> exploreMissions(Ref ref) async {
  ref.watch(dataRevisionProvider);
  final filters = ref.watch(missionFiltersControllerProvider);
  return (await ref.watch(missionsRepositoryProvider).fetchMissions(filters))
      .getOrThrow();
}

/// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.
@riverpod
Future<MissionPage> searchMissions(Ref ref, String query) async {
  ref.watch(dataRevisionProvider);
  final filters = ref
      .watch(missionFiltersControllerProvider)
      .copyWith(query: query);
  return (await ref.watch(missionsRepositoryProvider).fetchMissions(filters))
      .getOrThrow();
}

/// Compte en direct du bouton « Voir N missions » de la feuille Filtres.
@riverpod
Future<int> filtersPreviewCount(Ref ref, MissionFilters draft) async =>
    (await ref.watch(missionsRepositoryProvider).fetchMissions(draft))
        .getOrThrow()
        .total;

/// Pastilles par ville de la carte (B02).
@riverpod
Future<MissionMap> missionMap(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(missionsRepositoryProvider).fetchMissionMap())
      .getOrThrow();
}
