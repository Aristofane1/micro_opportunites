import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

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
    String? memberSince,
    String? pitch,
    @Default(<String>[]) List<String> skills,
    @Default(false) bool verified,
    @Default(false) bool isExpert,
    double? rating,
    @Default(0) int reviewsCount,
    @Default(0) int missionsCount,
    int? reliability,
    @Default(0) int absences,
    @Default(<DoneMissionModel>[]) List<DoneMissionModel> doneMissions,
    CandidateReviewModel? review,
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
    memberSince: _date(memberSince),
    pitch: pitch ?? '',
    skills: skills.join(', '),
    verified: verified,
    isExpert: isExpert,
    rating: rating,
    reviewsCount: reviewsCount,
    missionsCount: missionsCount,
    reliability: reliability,
    absences: absences,
    doneMissions: [for (final d in doneMissions) d.toEntity()],
    review: review?.toEntity(),
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

@freezed
abstract class DoneMissionModel with _$DoneMissionModel {
  const DoneMissionModel._();

  const factory DoneMissionModel({
    required String category,
    required int count,
  }) = _DoneMissionModel;

  factory DoneMissionModel.fromJson(Map<String, dynamic> json) =>
      _$DoneMissionModelFromJson(json);

  DoneMission toEntity() =>
      DoneMission(MissionCategory.fromApi(category), count);
}

@freezed
abstract class CandidateReviewModel with _$CandidateReviewModel {
  const CandidateReviewModel._();

  const factory CandidateReviewModel({
    required String author,
    required int stars,
    required String text,
    required int punctuality,
    required int quality,
    required int communication,
  }) = _CandidateReviewModel;

  factory CandidateReviewModel.fromJson(Map<String, dynamic> json) =>
      _$CandidateReviewModelFromJson(json);

  CandidateReview toEntity() => CandidateReview(
    author: author,
    stars: stars,
    text: text,
    punctuality: punctuality,
    quality: quality,
    communication: communication,
  );
}
