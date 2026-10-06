// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    _AssignmentModel(
      id: json['id'] as String,
      missionId: json['missionId'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      startAt: json['startAt'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      payAmount: (json['payAmount'] as num).toInt(),
      city: json['city'] as String,
      district: json['district'] as String,
      address: json['address'] as String,
      landmark: json['landmark'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      briefing: json['briefing'] as String,
      posterName: json['posterName'] as String,
      payoutOperator: json['payoutOperator'] as String,
      distanceKm: (json['distanceKm'] as num).toDouble(),
      travelMinutes: (json['travelMinutes'] as num).toInt(),
      checkInAt: json['checkInAt'] as String?,
      checkInDistanceM: (json['checkInDistanceM'] as num?)?.toInt(),
      checkOutAt: json['checkOutAt'] as String?,
      note: json['note'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      autoValidateAt: json['autoValidateAt'] as String?,
      contestReason: json['contestReason'] as String?,
      cancelledBy: json['cancelledBy'] as String?,
    );

Map<String, dynamic> _$AssignmentModelToJson(_AssignmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'missionId': instance.missionId,
      'title': instance.title,
      'status': instance.status,
      'startAt': instance.startAt,
      'durationMin': instance.durationMin,
      'payAmount': instance.payAmount,
      'city': instance.city,
      'district': instance.district,
      'address': instance.address,
      'landmark': instance.landmark,
      'lat': instance.lat,
      'lng': instance.lng,
      'briefing': instance.briefing,
      'posterName': instance.posterName,
      'payoutOperator': instance.payoutOperator,
      'distanceKm': instance.distanceKm,
      'travelMinutes': instance.travelMinutes,
      'checkInAt': instance.checkInAt,
      'checkInDistanceM': instance.checkInDistanceM,
      'checkOutAt': instance.checkOutAt,
      'note': instance.note,
      'photos': instance.photos,
      'autoValidateAt': instance.autoValidateAt,
      'contestReason': instance.contestReason,
      'cancelledBy': instance.cancelledBy,
    };
