import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission_model.freezed.dart';
part 'mission_model.g.dart';

/// JSON d'une mission publique (`GET /missions`, `GET /missions/:id`).
@freezed
abstract class MissionModel with _$MissionModel {
  const MissionModel._();

  const factory MissionModel({
    required String id,
    required String title,
    required String category,
    required String city,
    required String startAt,
    required int durationMin,
    required PayModel pay,
    required int slotsTotal,
    required int slotsFree,
    required String description,
    required String applyDeadline,
    required String publishedAt,
    required PosterSummaryModel poster,
    required int publicQuestionsCount,
    required bool alreadyApplied,
  }) = _MissionModel;

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);

  Mission toEntity() => Mission(
    id: id,
    title: title,
    category: MissionCategory.fromApi(category),
    city: city,
    startAt: DateTime.parse(startAt),
    durationMinutes: durationMin,
    payAmount: pay.amount,
    slotsTotal: slotsTotal,
    slotsFree: slotsFree,
    description: description,
    applyDeadline: DateTime.parse(applyDeadline),
    publishedAt: DateTime.parse(publishedAt),
    poster: poster.toEntity(),
    publicQuestionsCount: publicQuestionsCount,
    alreadyApplied: alreadyApplied,
  );
}

@freezed
abstract class PayModel with _$PayModel {
  const factory PayModel({required int amount, required String type}) =
      _PayModel;

  factory PayModel.fromJson(Map<String, dynamic> json) =>
      _$PayModelFromJson(json);
}

@freezed
abstract class PosterSummaryModel with _$PosterSummaryModel {
  const PosterSummaryModel._();

  const factory PosterSummaryModel({
    required String id,
    required String displayName,
    required String initials,
    required bool verified,
    required double rating,
    required int avgValidationHours,
  }) = _PosterSummaryModel;

  factory PosterSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PosterSummaryModelFromJson(json);

  PosterSummary toEntity() => PosterSummary(
    id: id,
    displayName: displayName,
    initials: initials,
    verified: verified,
    rating: rating,
    avgValidationHours: avgValidationHours,
  );
}
