import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission.freezed.dart';

/// Mission telle que vue par un candidat : ville seule, jamais d'adresse.
@freezed
abstract class Mission with _$Mission {
  const Mission._();

  const factory Mission({
    required String id,
    required String title,
    required MissionCategory category,
    required String city,
    required DateTime startAt,
    required int durationMinutes,
    required int payAmount,
    required int slotsTotal,
    required int slotsFree,
    required String description,
    required DateTime applyDeadline,
    required DateTime publishedAt,
    required PosterSummary poster,
    required int publicQuestionsCount,
    required bool alreadyApplied,
  }) = _Mission;

  Duration get duration => Duration(minutes: durationMinutes);
}

@freezed
abstract class PosterSummary with _$PosterSummary {
  const factory PosterSummary({
    required String id,
    required String displayName,
    required String initials,
    required bool verified,
    required double rating,
    required int avgValidationHours,
  }) = _PosterSummary;
}
