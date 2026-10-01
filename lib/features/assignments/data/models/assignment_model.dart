import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';

part 'assignment_model.freezed.dart';
part 'assignment_model.g.dart';

/// JSON de `GET /assignments/:id` et des actions check-in / check-out.
@freezed
abstract class AssignmentModel with _$AssignmentModel {
  const AssignmentModel._();

  const factory AssignmentModel({
    required String id,
    required String missionId,
    required String title,
    required String status,
    required String startAt,
    required int durationMin,
    required int payAmount,
    required String city,
    required String district,
    required String address,
    required String landmark,
    required double lat,
    required double lng,
    required String briefing,
    required String posterName,
    required String payoutOperator,
    required double distanceKm,
    required int travelMinutes,
    String? checkInAt,
    int? checkInDistanceM,
    String? checkOutAt,
    String? note,
    @Default(<String>[]) List<String> photos,
    String? autoValidateAt,
  }) = _AssignmentModel;

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Assignment toEntity() => Assignment(
    id: id,
    missionId: missionId,
    title: title,
    status: AssignmentStatus.fromApi(status),
    startAt: DateTime.parse(startAt),
    durationMinutes: durationMin,
    payAmount: payAmount,
    city: city,
    district: district,
    address: address,
    landmark: landmark,
    latitude: lat,
    longitude: lng,
    briefing: briefing,
    posterName: posterName,
    payoutOperator: payoutOperator,
    distanceKm: distanceKm,
    travelMinutes: travelMinutes,
    checkInAt: checkInAt == null ? null : DateTime.parse(checkInAt!),
    checkInDistanceMeters: checkInDistanceM,
    checkOutAt: checkOutAt == null ? null : DateTime.parse(checkOutAt!),
    note: note,
    photos: photos,
    autoValidateAt: autoValidateAt == null
        ? null
        : DateTime.parse(autoValidateAt!),
  );
}
