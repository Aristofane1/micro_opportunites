import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_method.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_method.dart';

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

    // Étape 4 : Payer
    @Default(PaymentMethod.mtnMomo) PaymentMethod paymentMethod,
  }) = _MissionDraft;

  /// Montant total à bloquer (hors frais de service).
  int get totalToBlock {
    final amount = payAmount ?? 0;
    return switch (payUnit) {
      PayUnit.flat => amount * slotsTotal,
      PayUnit.hourly => (amount * durationMinutes * slotsTotal / 60).round(),
      PayUnit.daily => amount * slotsTotal, // 1 jour par personne (hypothèse)
    };
  }
}
