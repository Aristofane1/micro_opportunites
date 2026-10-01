import 'package:freezed_annotation/freezed_annotation.dart';

part 'poster_profile.freezed.dart';

@freezed
abstract class PosterProfile with _$PosterProfile {
  const factory PosterProfile({
    required String id,
    required String displayName,
    required String initials,
    required bool verified,
    required bool reliable,
    required String city,
    required DateTime memberSince,
    required double rating,
    required int reviewsCount,
    required int paidMissions,
    required int avgValidationHours,
    required List<Review> reviews,
  }) = _PosterProfile;
}

@freezed
abstract class Review with _$Review {
  const factory Review({
    required String authorName,
    required int stars,
    required String comment,
    required String context,
    required DateTime date,
    String? reply,
  }) = _Review;
}
