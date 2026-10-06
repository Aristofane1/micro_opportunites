import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_method.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/core/dev/dev_start.dart';

part 'mission_draft_controller.g.dart';

// Brouillon de test
MissionDraft _buildTestDraft() {
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  return MissionDraft(
    title: 'Distribution de flyers au carrefour',
    category: MissionCategory.event,
    description:
        'Distribuer 500 flyers pour l\'ouverture d\'une boutique. Flyers et t-shirt fournis sur place.',
    city: 'Abomey-Calavi',
    address: 'Rue de la pharmacie, Godomey',
    landmark: 'Face à la station du carrefour, portail bleu',
    startAt: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 8),
    payAmount: 5000,
    slotsTotal: 5,
    applyDeadline: DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day - 1,
      18,
    ),
  );
}

@Riverpod(keepAlive: true)
class MissionDraftController extends _$MissionDraftController {
  @override
  MissionDraft build() =>
      startOnPublish ? _buildTestDraft() : const MissionDraft();
  // Étape 1 : Quoi ??
  void updateTitle(String value) => state = state.copyWith(title: value);

  void updateCategory(MissionCategory value) =>
      state = state.copyWith(category: value);

  void updateDescription(String value) =>
      state = state.copyWith(description: value);

  void addPhoto(String path) {
    if (state.photoPaths.length >= 3) return; // la maquette limite à 3 photos
    state = state.copyWith(photoPaths: [...state.photoPaths, path]);
  }

  void removePhoto(String path) {
    state = state.copyWith(
      photoPaths: state.photoPaths.where((p) => p != path).toList(),
    );
  }

  // Étape 2 : Où ??
  void updateCity(String value) => state = state.copyWith(city: value);

  void updateAddress(String value) => state = state.copyWith(address: value);

  void updateLandmark(String value) => state = state.copyWith(landmark: value);

  void updateEntrancePhoto(String? path) =>
      state = state.copyWith(entrancePhotoPath: path);

  void updatePin(double latitude, double longitude) {
    state = state.copyWith(latitude: latitude, longitude: longitude);
  }

  // Étape 3 : Quand et combien
  void updateDate(DateTime date) {
    final current = state.startAt;
    state = state.copyWith(
      startAt: DateTime(
        date.year,
        date.month,
        date.day,
        current?.hour ?? 8,
        current?.minute ?? 0,
      ),
      // Sans date limite choisie : la veille à 18 h, comme dans la maquette
      applyDeadline:
          state.applyDeadline ??
          DateTime(date.year, date.month, date.day - 1, 18),
    );
  }

  void updateTime(int hour, int minute) {
    final base = state.startAt ?? DateTime.now().add(const Duration(days: 1));
    state = state.copyWith(
      startAt: DateTime(base.year, base.month, base.day, hour, minute),
    );
  }

  void updateDuration(int minutes) =>
      state = state.copyWith(durationMinutes: minutes);

  void updatePayAmount(int? value) => state = state.copyWith(payAmount: value);

  void updatePayUnit(PayUnit value) => state = state.copyWith(payUnit: value);

  void increaseSlots() {
    if (state.slotsTotal >= 50) return;
    state = state.copyWith(slotsTotal: state.slotsTotal + 1);
  }

  void decreaseSlots() {
    if (state.slotsTotal <= 1) return;
    state = state.copyWith(slotsTotal: state.slotsTotal - 1);
  }

  void updateApplyDeadline(DateTime value) =>
      state = state.copyWith(applyDeadline: value);

  // Étape 4 : Payer
  void updatePaymentMethod(PaymentMethod value) =>
      state = state.copyWith(paymentMethod: value);
  // Repartir de zéro (après publication ou annulation)
  void reset() => state = const MissionDraft();
}
