import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment.freezed.dart';

enum AssignmentStatus {
  confirmed('confirmed'),
  inProgress('in_progress'),
  submitted('submitted'),
  contested('contested'),
  paid('paid'),
  cancelled('cancelled');

  const AssignmentStatus(this.apiValue);

  final String apiValue;

  static AssignmentStatus fromApi(String value) =>
      values.firstWhere((s) => s.apiValue == value, orElse: () => cancelled);
}

/// Mission confirmée pour l'exécutant : adresse exacte incluse.
@freezed
abstract class Assignment with _$Assignment {
  const Assignment._();

  const factory Assignment({
    required String id,
    required String missionId,
    required String title,
    required AssignmentStatus status,
    required DateTime startAt,
    required int durationMinutes,
    required int payAmount,
    required String city,
    required String district,
    required String address,
    required String landmark,
    required double latitude,
    required double longitude,
    required String briefing,
    required String posterName,
    required String payoutOperator,
    required double distanceKm,
    required int travelMinutes,
    DateTime? checkInAt,
    int? checkInDistanceMeters,
    DateTime? checkOutAt,
    String? note,
    @Default(<String>[]) List<String> photos,
    DateTime? autoValidateAt,
    String? contestReason,
  }) = _Assignment;

  Duration get duration => Duration(minutes: durationMinutes);
}
