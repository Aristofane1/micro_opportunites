import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission_summary.freezed.dart';

/// Une mission telle qu'elle apparaît dans la liste de l'Annonceur.
@freezed
abstract class MissionSummary with _$MissionSummary {
  const MissionSummary._();

  const factory MissionSummary({
    required String id,
    required String title,
    required MissionStatus status,
    required DateTime startAt,
    required String city,
    required String payLabel, // ex. « 5 000 FCFA / pers. »
    required int slotsTotal,
    MissionCategory? category,
    @Default(240) int durationMinutes,
    @Default(0) int slotsConfirmed,
    @Default(0) int slotsOffered, // place proposée, pas encore acceptée
    @Default(0) int applicantsCount,
    @Default(0) int newApplicantsCount,
    @Default(0) int blockedAmount,
  }) = _MissionSummary;

  int get slotsFree => slotsTotal - slotsConfirmed - slotsOffered;

  /// Ce que touche chaque personne (montant bloqué ÷ nombre de places)
  int get amountPerSlot => slotsTotal == 0 ? 0 : blockedAmount ~/ slotsTotal;

  DateTime get endAt => startAt.add(Duration(minutes: durationMinutes));
}
