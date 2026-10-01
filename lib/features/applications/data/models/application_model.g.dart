// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: json['id'] as String,
      missionId: json['missionId'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      createdAt: json['createdAt'] as String,
      offerExpiresAt: json['offerExpiresAt'] as String?,
      assignmentId: json['assignmentId'] as String?,
      mission: ApplicationMissionModel.fromJson(
        json['mission'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ApplicationModelToJson(_ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'missionId': instance.missionId,
      'status': instance.status,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'offerExpiresAt': instance.offerExpiresAt,
      'assignmentId': instance.assignmentId,
      'mission': instance.mission,
    };

_ApplicationMissionModel _$ApplicationMissionModelFromJson(
  Map<String, dynamic> json,
) => _ApplicationMissionModel(
  title: json['title'] as String,
  city: json['city'] as String,
  startAt: json['startAt'] as String,
  durationMin: (json['durationMin'] as num).toInt(),
  payAmount: (json['payAmount'] as num).toInt(),
  posterName: json['posterName'] as String,
  posterRating: (json['posterRating'] as num).toDouble(),
  posterVerified: json['posterVerified'] as bool,
);

Map<String, dynamic> _$ApplicationMissionModelToJson(
  _ApplicationMissionModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'city': instance.city,
  'startAt': instance.startAt,
  'durationMin': instance.durationMin,
  'payAmount': instance.payAmount,
  'posterName': instance.posterName,
  'posterRating': instance.posterRating,
  'posterVerified': instance.posterVerified,
};
