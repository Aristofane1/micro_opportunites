// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionPageModel _$MissionPageModelFromJson(Map<String, dynamic> json) =>
    _MissionPageModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => MissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      radiusKm: (json['radiusKm'] as num).toInt(),
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$MissionPageModelToJson(_MissionPageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'radiusKm': instance.radiusKm,
      'updatedAt': instance.updatedAt,
    };
