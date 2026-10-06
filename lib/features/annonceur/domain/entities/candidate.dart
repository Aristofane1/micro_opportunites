import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidate.freezed.dart';

/// Où en est la candidature.
enum CandidateStatus { pending, retained, confirmed, refused }

/// Où en est la personne le jour de la mission.
enum AttendanceStatus {
  notArrived,
  arrived,
  finished, // a signalé la fin : travail à valider
  validated, // travail validé, paiement versé
  contested, // l'annonceur a contesté le travail
}

@freezed
abstract class Candidate with _$Candidate {
  const Candidate._();

  const factory Candidate({
    required String id, // identifiant de la candidature
    required String name, // « Sènami O. »
    required String city,
    required DateTime memberSince,
    required String pitch, // la présentation du candidat
    required String skills,
    @Default(false) bool verified,
    double? rating,
    @Default(0) int reviewsCount,
    @Default(0) int missionsCount,
    int? reliability, // en pourcentage
    @Default(0) int absences,
    @Default(CandidateStatus.pending) CandidateStatus status,
    @Default(AttendanceStatus.notArrived) AttendanceStatus attendance,
    String? assignmentId,
    DateTime? arrivedAt,
    DateTime? finishedAt,
    DateTime? autoPayAt, // sans réponse, le paiement part à cette heure
    DateTime? offerExpiresAt,
    int? distanceMeters,
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
}
