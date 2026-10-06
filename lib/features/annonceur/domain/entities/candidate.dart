import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'candidate.freezed.dart';

/// Où en est la candidature.
enum CandidateStatus { pending, retained, confirmed, refused }

/// Où en est la personne le jour de la mission.
enum AttendanceStatus {
  notArrived,
  arrived,
  unconfirmed, // GPS faible : l'annonceur doit confirmer la présence
  finished, // a signalé la fin : travail à valider
  validated, // travail validé, paiement versé
  absent,
}

/// « Événement × 9 »
class DoneMission {
  const DoneMission(this.category, this.count);
  final MissionCategory category;
  final int count;
}

class CandidateReview {
  const CandidateReview({
    required this.author,
    required this.stars,
    required this.text,
    required this.punctuality,
    required this.quality,
    required this.communication,
  });

  final String author;
  final int stars;
  final String text;
  final int punctuality;
  final int quality;
  final int communication;
}

@freezed
abstract class Candidate with _$Candidate {
  const Candidate._();

  const factory Candidate({
    required String id,
    required String name, // « Sènami O. »
    required String city,
    required String memberSince, // « janv. 2026 »
    required String pitch, // le message du candidat
    required String skills,
    @Default(false) bool verified,
    @Default(false) bool isExpert,
    double? rating,
    @Default(0) int reviewsCount,
    @Default(0) int missionsCount,
    int? reliability, // en pourcentage
    @Default(0) int absences,
    @Default([]) List<DoneMission> doneMissions,
    CandidateReview? review,
    @Default(CandidateStatus.pending) CandidateStatus status,
    @Default(AttendanceStatus.notArrived) AttendanceStatus attendance,
    DateTime? arrivedAt,
    DateTime? finishedAt,
    DateTime? noCheckInAt,
    int? distanceMeters,
    @Default(true) bool gpsPrecise,
    @Default(0) int proofPhotos,
    String? completionNote,
  }) = _Candidate;

  /// « Sènami O. » -> « SO »
  String get initials {
    final parts = name.split(' ').where((p) => p.isNotEmpty);
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

  String get firstName => name.split(' ').first;

  bool get isNew => missionsCount == 0;

  /// Sans réponse de l'annonceur, le paiement part 48 h après la fin signalée.
  DateTime? get autoPayAt => finishedAt?.add(const Duration(hours: 48));
}
