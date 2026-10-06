// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CandidateModel _$CandidateModelFromJson(Map<String, dynamic> json) =>
    _CandidateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      memberSince: json['memberSince'] as String,
      pitch: json['pitch'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      verified: json['verified'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      missionsCount: (json['missionsCount'] as num?)?.toInt() ?? 0,
      reliability: (json['reliability'] as num?)?.toInt(),
      absences: (json['absences'] as num?)?.toInt() ?? 0,
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
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'missionsCount': instance.missionsCount,
      'reliability': instance.reliability,
      'absences': instance.absences,
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
