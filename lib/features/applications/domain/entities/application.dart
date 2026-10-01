import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.freezed.dart';

enum ApplicationStatus {
  pendingSync('pending_sync'),
  pending('pending'),
  offered('offered'),
  confirmed('confirmed'),
  declined('declined'),
  withdrawn('withdrawn'),
  rejected('rejected'),
  expired('expired');

  const ApplicationStatus(this.apiValue);

  final String apiValue;

  /// Onglet « En cours » de B08 ; les autres vont dans « Passées ».
  bool get isCurrent =>
      this == pendingSync ||
      this == pending ||
      this == offered ||
      this == confirmed;

  static ApplicationStatus fromApi(String value) =>
      values.firstWhere((s) => s.apiValue == value, orElse: () => expired);
}

@freezed
abstract class Application with _$Application {
  const factory Application({
    required String id,
    required String missionId,
    required ApplicationStatus status,
    required String message,
    required DateTime createdAt,
    DateTime? offerExpiresAt,
    String? assignmentId,
    required ApplicationMission mission,
  }) = _Application;
}

/// Résumé de la mission joint à la candidature (jamais d'adresse).
@freezed
abstract class ApplicationMission with _$ApplicationMission {
  const ApplicationMission._();

  const factory ApplicationMission({
    required String title,
    required String city,
    required DateTime startAt,
    required int durationMinutes,
    required int payAmount,
    required String posterName,
    required double posterRating,
    required bool posterVerified,
  }) = _ApplicationMission;

  Duration get duration => Duration(minutes: durationMinutes);
}
