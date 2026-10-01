// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionModel _$MissionModelFromJson(Map<String, dynamic> json) =>
    _MissionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      city: json['city'] as String,
      startAt: json['startAt'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      pay: PayModel.fromJson(json['pay'] as Map<String, dynamic>),
      slotsTotal: (json['slotsTotal'] as num).toInt(),
      slotsFree: (json['slotsFree'] as num).toInt(),
      description: json['description'] as String,
      applyDeadline: json['applyDeadline'] as String,
      publishedAt: json['publishedAt'] as String,
      poster: PosterSummaryModel.fromJson(
        json['poster'] as Map<String, dynamic>,
      ),
      publicQuestionsCount: (json['publicQuestionsCount'] as num).toInt(),
      alreadyApplied: json['alreadyApplied'] as bool,
    );

Map<String, dynamic> _$MissionModelToJson(_MissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'city': instance.city,
      'startAt': instance.startAt,
      'durationMin': instance.durationMin,
      'pay': instance.pay,
      'slotsTotal': instance.slotsTotal,
      'slotsFree': instance.slotsFree,
      'description': instance.description,
      'applyDeadline': instance.applyDeadline,
      'publishedAt': instance.publishedAt,
      'poster': instance.poster,
      'publicQuestionsCount': instance.publicQuestionsCount,
      'alreadyApplied': instance.alreadyApplied,
    };

_PayModel _$PayModelFromJson(Map<String, dynamic> json) => _PayModel(
  amount: (json['amount'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$PayModelToJson(_PayModel instance) => <String, dynamic>{
  'amount': instance.amount,
  'type': instance.type,
};

_PosterSummaryModel _$PosterSummaryModelFromJson(Map<String, dynamic> json) =>
    _PosterSummaryModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      initials: json['initials'] as String,
      verified: json['verified'] as bool,
      rating: (json['rating'] as num).toDouble(),
      avgValidationHours: (json['avgValidationHours'] as num).toInt(),
    );

Map<String, dynamic> _$PosterSummaryModelToJson(_PosterSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'initials': instance.initials,
      'verified': instance.verified,
      'rating': instance.rating,
      'avgValidationHours': instance.avgValidationHours,
    };
