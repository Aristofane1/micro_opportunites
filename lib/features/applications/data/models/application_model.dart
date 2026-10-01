import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

/// JSON d'une candidature (`GET /me/applications`, actions).
@freezed
abstract class ApplicationModel with _$ApplicationModel {
  const ApplicationModel._();

  const factory ApplicationModel({
    required String id,
    required String missionId,
    required String status,
    required String message,
    required String createdAt,
    String? offerExpiresAt,
    String? assignmentId,
    required ApplicationMissionModel mission,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);

  Application toEntity() => Application(
    id: id,
    missionId: missionId,
    status: ApplicationStatus.fromApi(status),
    message: message,
    createdAt: DateTime.parse(createdAt),
    offerExpiresAt: offerExpiresAt == null
        ? null
        : DateTime.parse(offerExpiresAt!),
    assignmentId: assignmentId,
    mission: mission.toEntity(),
  );
}

@freezed
abstract class ApplicationMissionModel with _$ApplicationMissionModel {
  const ApplicationMissionModel._();

  const factory ApplicationMissionModel({
    required String title,
    required String city,
    required String startAt,
    required int durationMin,
    required int payAmount,
    required String posterName,
    required double posterRating,
    required bool posterVerified,
  }) = _ApplicationMissionModel;

  factory ApplicationMissionModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationMissionModelFromJson(json);

  ApplicationMission toEntity() => ApplicationMission(
    title: title,
    city: city,
    startAt: DateTime.parse(startAt),
    durationMinutes: durationMin,
    payAmount: payAmount,
    posterName: posterName,
    posterRating: posterRating,
    posterVerified: posterVerified,
  );
}
