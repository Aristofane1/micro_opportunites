import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/data/models/mission_model.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_page.dart';

part 'mission_page_model.freezed.dart';
part 'mission_page_model.g.dart';

@freezed
abstract class MissionPageModel with _$MissionPageModel {
  const MissionPageModel._();

  const factory MissionPageModel({
    required List<MissionModel> items,
    required int total,
    required int radiusKm,
    required String updatedAt,
  }) = _MissionPageModel;

  factory MissionPageModel.fromJson(Map<String, dynamic> json) =>
      _$MissionPageModelFromJson(json);

  MissionPage toEntity() => MissionPage(
    items: [for (final item in items) item.toEntity()],
    total: total,
    radiusKm: radiusKm,
    updatedAt: DateTime.parse(updatedAt),
  );
}
