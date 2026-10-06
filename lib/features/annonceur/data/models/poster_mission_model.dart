import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'poster_mission_model.freezed.dart';
part 'poster_mission_model.g.dart';

/// JSON d'une mission vue par son annonceur (`GET /me/missions`…).
@freezed
abstract class PosterMissionModel with _$PosterMissionModel {
  const PosterMissionModel._();

  const factory PosterMissionModel({
    required String id,
    required String title,
    required String category,
    required String city,
    required String startAt,
    required int durationMin,
    required int payAmount,
    required String payUnit,
    required int slotsTotal,
    required int slotsConfirmed,
    required int slotsOffered,
    required int applicantsCount,
    required int newApplicantsCount,
    required int blockedAmount,
    required String status,
  }) = _PosterMissionModel;

  factory PosterMissionModel.fromJson(Map<String, dynamic> json) =>
      _$PosterMissionModelFromJson(json);

  MissionSummary toEntity() => MissionSummary(
    id: id,
    title: title,
    status: MissionStatus.fromApi(status),
    startAt: DateTime.parse(startAt),
    city: city,
    payAmount: payAmount,
    payUnit: PayUnit.values.asNameMap()[payUnit] ?? PayUnit.flat,
    slotsTotal: slotsTotal,
    category: MissionCategory.fromApi(category),
    durationMinutes: durationMin,
    slotsConfirmed: slotsConfirmed,
    slotsOffered: slotsOffered,
    applicantsCount: applicantsCount,
    newApplicantsCount: newApplicantsCount,
    blockedAmount: blockedAmount,
  );
}
