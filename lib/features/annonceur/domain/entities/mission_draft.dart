import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission_draft.freezed.dart';

@freezed
abstract class MissionDraft with _$MissionDraft {
  const MissionDraft._(); // nécessaire pour pouvoir ajouter des getters

  const factory MissionDraft({
    // Étape 1 : Quoi ??
    String? title,
    MissionCategory? category,
    String? description,
    @Default([]) List<String> photoPaths,

    // Étape 2 : Où ??
    String? city,
    String? address,
    String? landmark,
    String? entrancePhotoPath,
    double? latitude,
    double? longitude,

    // Étape 3 : Quand et combien ??
    DateTime? startAt,
    @Default(240) int durationMinutes,
    int? payAmount,
    @Default(PayUnit.flat) PayUnit payUnit,
    @Default(1) int slotsTotal,
    DateTime? applyDeadline,
  }) = _MissionDraft;

  /// Montant total à bloquer (hors frais de service).
  int get totalToBlock {
    final amount = payAmount ?? 0;
    return switch (payUnit) {
      PayUnit.flat => amount * slotsTotal,
      // Même calcul que le serveur : montant d'une place arrondi, × places
      PayUnit.hourly => (amount * durationMinutes / 60).round() * slotsTotal,
      PayUnit.daily => amount * slotsTotal, // 1 jour par personne (hypothèse)
    };
  }
}
