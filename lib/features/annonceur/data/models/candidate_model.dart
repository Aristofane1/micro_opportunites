import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';

part 'candidate_model.freezed.dart';
part 'candidate_model.g.dart';

DateTime? _date(String? value) => value == null ? null : DateTime.parse(value);

/// JSON d'un candidat vu par l'annonceur (`GET /missions/:id/candidates`,
/// actions sur candidature et affectation).
@freezed
abstract class CandidateModel with _$CandidateModel {
  const CandidateModel._();

  const factory CandidateModel({
    required String id,
    required String name,
    required String city,
    required String memberSince,
    String? pitch,
    @Default(<String>[]) List<String> skills,
    @Default(false) bool verified,
    double? rating,
    @Default(0) int reviewsCount,
    @Default(0) int missionsCount,
    int? reliability,
    @Default(0) int absences,
    required String status,
    required String attendance,
    String? assignmentId,
    String? arrivedAt,
    String? finishedAt,
    String? autoPayAt,
    int? distanceMeters,
    @Default(0) int proofPhotos,
    String? completionNote,
    String? offerExpiresAt,
  }) = _CandidateModel;

  factory CandidateModel.fromJson(Map<String, dynamic> json) =>
      _$CandidateModelFromJson(json);

  Candidate toEntity() => Candidate(
    id: id,
    name: name,
    city: city,
    memberSince: DateTime.parse(memberSince),
    pitch: pitch ?? '',
    skills: skills.join(', '),
    verified: verified,
    rating: rating,
    reviewsCount: reviewsCount,
    missionsCount: missionsCount,
    reliability: reliability,
    absences: absences,
    status:
        CandidateStatus.values.asNameMap()[status] ?? CandidateStatus.refused,
    attendance:
        AttendanceStatus.values.asNameMap()[attendance] ??
        AttendanceStatus.notArrived,
    assignmentId: assignmentId,
    arrivedAt: _date(arrivedAt),
    finishedAt: _date(finishedAt),
    autoPayAt: _date(autoPayAt),
    distanceMeters: distanceMeters,
    proofPhotos: proofPhotos,
    completionNote: completionNote,
    offerExpiresAt: _date(offerExpiresAt),
  );
}
