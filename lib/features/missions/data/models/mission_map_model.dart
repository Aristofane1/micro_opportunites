import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_map.dart';

part 'mission_map_model.freezed.dart';
part 'mission_map_model.g.dart';

@freezed
abstract class MissionMapModel with _$MissionMapModel {
  const MissionMapModel._();

  const factory MissionMapModel({
    required List<CityClusterModel> items,
    required double userLat,
    required double userLng,
  }) = _MissionMapModel;

  factory MissionMapModel.fromJson(Map<String, dynamic> json) =>
      _$MissionMapModelFromJson(json);

  MissionMap toEntity() => MissionMap(
    clusters: [for (final item in items) item.toEntity()],
    userLatitude: userLat,
    userLongitude: userLng,
  );
}

@freezed
abstract class CityClusterModel with _$CityClusterModel {
  const CityClusterModel._();

  const factory CityClusterModel({
    required String city,
    required int count,
    required double lat,
    required double lng,
    required int minPay,
    required int maxPay,
  }) = _CityClusterModel;

  factory CityClusterModel.fromJson(Map<String, dynamic> json) =>
      _$CityClusterModelFromJson(json);

  CityCluster toEntity() => CityCluster(
    city: city,
    count: count,
    latitude: lat,
    longitude: lng,
    minPay: minPay,
    maxPay: maxPay,
  );
}
