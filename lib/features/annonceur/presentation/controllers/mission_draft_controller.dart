import 'package:micro_opportunites/core/time/clock.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'mission_draft_controller.g.dart';

@Riverpod(keepAlive: true)
class MissionDraftController extends _$MissionDraftController {
  /// Vrai quand l'annonceur a choisi lui-même la date limite : elle n'est
  /// plus recalculée quand la date ou l'heure de début change.
  bool _deadlineChosen = false;

  @override
  MissionDraft build() {
    _deadlineChosen = false;
    return const MissionDraft();
  }

  DateTime _now() => ref.read(clockProvider)();
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
    );
    _applyDefaultDeadline();
  }

  void updateTime(int hour, int minute) {
    final base = state.startAt ?? _now().add(const Duration(days: 1));
    state = state.copyWith(
      startAt: DateTime(base.year, base.month, base.day, hour, minute),
    );
    _applyDefaultDeadline();
  }

  /// Sans date limite choisie : la veille à 18 h (maquette) ; si elle est
  /// déjà passée (mission du jour), 1 h avant le début ; jamais dans le
  /// passé (sinon l'annonceur la choisit).
  void _applyDefaultDeadline() {
    final start = state.startAt;
    if (_deadlineChosen || start == null) return;
    final now = _now();
    final candidates = [
      DateTime(start.year, start.month, start.day - 1, 18),
      start.subtract(const Duration(hours: 1)),
    ]..sort();
    final deadline = candidates.where((d) => d.isAfter(now)).firstOrNull;
    state = state.copyWith(applyDeadline: deadline);
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

  void updateApplyDeadline(DateTime value) {
    _deadlineChosen = true;
    state = state.copyWith(applyDeadline: value);
  }

  // Repartir de zéro (après publication ou annulation)
  void reset() {
    _deadlineChosen = false;
    state = const MissionDraft();
  }
}
