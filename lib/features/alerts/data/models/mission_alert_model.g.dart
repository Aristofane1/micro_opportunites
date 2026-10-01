// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionAlertModel _$MissionAlertModelFromJson(Map<String, dynamic> json) =>
    _MissionAlertModel(
      id: json['id'] as String,
      keyword: json['keyword'] as String?,
      category: json['category'] as String?,
      zone: json['zone'] as String,
      minPay: (json['minPay'] as num?)?.toInt(),
      days: json['days'] as String,
    );

Map<String, dynamic> _$MissionAlertModelToJson(_MissionAlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keyword': instance.keyword,
      'category': instance.category,
      'zone': instance.zone,
      'minPay': instance.minPay,
      'days': instance.days,
    };
