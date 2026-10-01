// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PosterProfileModel _$PosterProfileModelFromJson(Map<String, dynamic> json) =>
    _PosterProfileModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      initials: json['initials'] as String,
      verified: json['verified'] as bool,
      reliable: json['reliable'] as bool,
      city: json['city'] as String,
      memberSince: json['memberSince'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: (json['reviewsCount'] as num).toInt(),
      paidMissions: (json['paidMissions'] as num).toInt(),
      avgValidationHours: (json['avgValidationHours'] as num).toInt(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosterProfileModelToJson(_PosterProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'initials': instance.initials,
      'verified': instance.verified,
      'reliable': instance.reliable,
      'city': instance.city,
      'memberSince': instance.memberSince,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'paidMissions': instance.paidMissions,
      'avgValidationHours': instance.avgValidationHours,
      'reviews': instance.reviews,
    };

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  authorName: json['authorName'] as String,
  stars: (json['stars'] as num).toInt(),
  comment: json['comment'] as String,
  context: json['context'] as String,
  date: json['date'] as String,
  reply: json['reply'] as String?,
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'authorName': instance.authorName,
      'stars': instance.stars,
      'comment': instance.comment,
      'context': instance.context,
      'date': instance.date,
      'reply': instance.reply,
    };
