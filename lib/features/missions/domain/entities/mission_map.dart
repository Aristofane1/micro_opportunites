import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_map.freezed.dart';

/// Pastille d'une ville sur la carte (jamais de point précis).
@freezed
abstract class CityCluster with _$CityCluster {
  const factory CityCluster({
    required String city,
    required int count,
    required double latitude,
    required double longitude,
    required int minPay,
    required int maxPay,
  }) = _CityCluster;
}

@freezed
abstract class MissionMap with _$MissionMap {
  const factory MissionMap({
    required List<CityCluster> clusters,
    required double userLatitude,
    required double userLongitude,
  }) = _MissionMap;
}
