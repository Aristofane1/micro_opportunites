import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mission_filters_controller.g.dart';

/// Filtres courants d'Explorer, partagés par la liste, la feuille Filtres,
/// la carte et la recherche. Conservés tant que l'app tourne.
@Riverpod(keepAlive: true)
class MissionFiltersController extends _$MissionFiltersController {
  @override
  MissionFilters build() => const MissionFilters();

  void apply(MissionFilters filters) => state = filters.copyWith(query: null);

  /// Puce rapide d'Explorer : `null` = « Tout ».
  void selectQuickCategory(MissionCategory? category) => state = state.copyWith(
    categories: category == null ? <MissionCategory>{} : {category},
  );

  void setCity(String? city) => state = state.copyWith(city: city);

  void reset() => state = const MissionFilters();
}
