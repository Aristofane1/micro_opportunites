import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
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
    required int payAmount,
    required PayUnit payUnit,
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

  /// « 5 000 FCFA / pers. » (ou « / h », « / jour » selon l'unité)
  String get payLabel {
    final suffix = switch (payUnit) {
      PayUnit.flat => 'pers.',
      PayUnit.hourly => 'h',
      PayUnit.daily => 'jour',
    };
    return '${formatFcfa(payAmount)} / $suffix';
  }

  /// Ce que touche chaque personne : le taux, ou taux × durée à l'heure
  /// (même calcul que le montant bloqué par place côté serveur).
  int get amountPerSlot => payUnit == PayUnit.hourly
      ? (payAmount * durationMinutes / 60).round()
      : payAmount;

  DateTime get endAt => startAt.add(Duration(minutes: durationMinutes));
}
