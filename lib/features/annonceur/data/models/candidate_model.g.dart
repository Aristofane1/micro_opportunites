// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CandidateModel _$CandidateModelFromJson(
  Map<String, dynamic> json,
) => _CandidateModel(
  id: json['id'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  memberSince: json['memberSince'] as String?,
  pitch: json['pitch'] as String?,
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  verified: json['verified'] as bool? ?? false,
  isExpert: json['isExpert'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
  missionsCount: (json['missionsCount'] as num?)?.toInt() ?? 0,
  reliability: (json['reliability'] as num?)?.toInt(),
  absences: (json['absences'] as num?)?.toInt() ?? 0,
  doneMissions:
      (json['doneMissions'] as List<dynamic>?)
          ?.map((e) => DoneMissionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DoneMissionModel>[],
  review: json['review'] == null
      ? null
      : CandidateReviewModel.fromJson(json['review'] as Map<String, dynamic>),
  status: json['status'] as String,
  attendance: json['attendance'] as String,
  assignmentId: json['assignmentId'] as String?,
  arrivedAt: json['arrivedAt'] as String?,
  finishedAt: json['finishedAt'] as String?,
  autoPayAt: json['autoPayAt'] as String?,
  distanceMeters: (json['distanceMeters'] as num?)?.toInt(),
  proofPhotos: (json['proofPhotos'] as num?)?.toInt() ?? 0,
  completionNote: json['completionNote'] as String?,
  offerExpiresAt: json['offerExpiresAt'] as String?,
);

Map<String, dynamic> _$CandidateModelToJson(_CandidateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'memberSince': instance.memberSince,
      'pitch': instance.pitch,
      'skills': instance.skills,
      'verified': instance.verified,
      'isExpert': instance.isExpert,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'missionsCount': instance.missionsCount,
      'reliability': instance.reliability,
      'absences': instance.absences,
      'doneMissions': instance.doneMissions,
      'review': instance.review,
      'status': instance.status,
      'attendance': instance.attendance,
      'assignmentId': instance.assignmentId,
      'arrivedAt': instance.arrivedAt,
      'finishedAt': instance.finishedAt,
      'autoPayAt': instance.autoPayAt,
      'distanceMeters': instance.distanceMeters,
      'proofPhotos': instance.proofPhotos,
      'completionNote': instance.completionNote,
      'offerExpiresAt': instance.offerExpiresAt,
    };

_DoneMissionModel _$DoneMissionModelFromJson(Map<String, dynamic> json) =>
    _DoneMissionModel(
      category: json['category'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$DoneMissionModelToJson(_DoneMissionModel instance) =>
    <String, dynamic>{'category': instance.category, 'count': instance.count};

_CandidateReviewModel _$CandidateReviewModelFromJson(
  Map<String, dynamic> json,
) => _CandidateReviewModel(
  author: json['author'] as String,
  stars: (json['stars'] as num).toInt(),
  text: json['text'] as String,
  punctuality: (json['punctuality'] as num).toInt(),
  quality: (json['quality'] as num).toInt(),
  communication: (json['communication'] as num).toInt(),
);

Map<String, dynamic> _$CandidateReviewModelToJson(
  _CandidateReviewModel instance,
) => <String, dynamic>{
  'author': instance.author,
  'stars': instance.stars,
  'text': instance.text,
  'punctuality': instance.punctuality,
  'quality': instance.quality,
  'communication': instance.communication,
};
