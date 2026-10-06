// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster_mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PosterMissionModel _$PosterMissionModelFromJson(Map<String, dynamic> json) =>
    _PosterMissionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      city: json['city'] as String,
      startAt: json['startAt'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      payAmount: (json['payAmount'] as num).toInt(),
      payUnit: json['payUnit'] as String,
      slotsTotal: (json['slotsTotal'] as num).toInt(),
      slotsConfirmed: (json['slotsConfirmed'] as num).toInt(),
      slotsOffered: (json['slotsOffered'] as num).toInt(),
      applicantsCount: (json['applicantsCount'] as num).toInt(),
      newApplicantsCount: (json['newApplicantsCount'] as num).toInt(),
      blockedAmount: (json['blockedAmount'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PosterMissionModelToJson(_PosterMissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'city': instance.city,
      'startAt': instance.startAt,
      'durationMin': instance.durationMin,
      'payAmount': instance.payAmount,
      'payUnit': instance.payUnit,
      'slotsTotal': instance.slotsTotal,
      'slotsConfirmed': instance.slotsConfirmed,
      'slotsOffered': instance.slotsOffered,
      'applicantsCount': instance.applicantsCount,
      'newApplicantsCount': instance.newApplicantsCount,
      'blockedAmount': instance.blockedAmount,
      'status': instance.status,
    };
