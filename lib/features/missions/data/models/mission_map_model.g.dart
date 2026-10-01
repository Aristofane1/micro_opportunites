// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionMapModel _$MissionMapModelFromJson(Map<String, dynamic> json) =>
    _MissionMapModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CityClusterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userLat: (json['userLat'] as num).toDouble(),
      userLng: (json['userLng'] as num).toDouble(),
    );

Map<String, dynamic> _$MissionMapModelToJson(_MissionMapModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'userLat': instance.userLat,
      'userLng': instance.userLng,
    };

_CityClusterModel _$CityClusterModelFromJson(Map<String, dynamic> json) =>
    _CityClusterModel(
      city: json['city'] as String,
      count: (json['count'] as num).toInt(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      minPay: (json['minPay'] as num).toInt(),
      maxPay: (json['maxPay'] as num).toInt(),
    );

Map<String, dynamic> _$CityClusterModelToJson(_CityClusterModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'count': instance.count,
      'lat': instance.lat,
      'lng': instance.lng,
      'minPay': instance.minPay,
      'maxPay': instance.maxPay,
    };
