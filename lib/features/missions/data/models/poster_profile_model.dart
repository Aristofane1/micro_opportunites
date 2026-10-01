import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/poster_profile.dart';

part 'poster_profile_model.freezed.dart';
part 'poster_profile_model.g.dart';

@freezed
abstract class PosterProfileModel with _$PosterProfileModel {
  const PosterProfileModel._();

  const factory PosterProfileModel({
    required String id,
    required String displayName,
    required String initials,
    required bool verified,
    required bool reliable,
    required String city,
    required String memberSince,
    required double rating,
    required int reviewsCount,
    required int paidMissions,
    required int avgValidationHours,
    required List<ReviewModel> reviews,
  }) = _PosterProfileModel;

  factory PosterProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PosterProfileModelFromJson(json);

  PosterProfile toEntity() => PosterProfile(
    id: id,
    displayName: displayName,
    initials: initials,
    verified: verified,
    reliable: reliable,
    city: city,
    memberSince: DateTime.parse(memberSince),
    rating: rating,
    reviewsCount: reviewsCount,
    paidMissions: paidMissions,
    avgValidationHours: avgValidationHours,
    reviews: [for (final review in reviews) review.toEntity()],
  );
}

@freezed
abstract class ReviewModel with _$ReviewModel {
  const ReviewModel._();

  const factory ReviewModel({
    required String authorName,
    required int stars,
    required String comment,
    required String context,
    required String date,
    String? reply,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Review toEntity() => Review(
    authorName: authorName,
    stars: stars,
    comment: comment,
    context: context,
    date: DateTime.parse(date),
    reply: reply,
  );
}
