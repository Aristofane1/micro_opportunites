import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission_filters.freezed.dart';

enum MissionPeriod {
  today('today', 'Aujourd’hui'),
  week('week', 'Cette semaine'),
  all('all', 'Tout');

  const MissionPeriod(this.apiValue, this.label);

  final String apiValue;
  final String label;
}

/// Critères de recherche (feuille Filtres, puces, carte, recherche).
@freezed
abstract class MissionFilters with _$MissionFilters {
  const MissionFilters._();

  const factory MissionFilters({
    @Default(5) int radiusKm,
    @Default(<MissionCategory>{}) Set<MissionCategory> categories,
    int? minPay,
    @Default(MissionPeriod.all) MissionPeriod period,
    @Default(false) bool multiSlotsOnly,
    String? city,
    String? query,
  }) = _MissionFilters;

  static const radiusOptions = [2, 5, 10, 20];

  /// Nombre de filtres actifs (pastille du bouton Filtres).
  int get activeCount =>
      categories.length +
      (minPay != null ? 1 : 0) +
      (period != MissionPeriod.all ? 1 : 0) +
      (multiSlotsOnly ? 1 : 0) +
      (radiusKm != 5 ? 1 : 0) +
      (city != null ? 1 : 0);
}
