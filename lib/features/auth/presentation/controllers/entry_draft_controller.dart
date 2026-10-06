import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_draft_controller.freezed.dart';
part 'entry_draft_controller.g.dart';

/// Ce que l'utilisateur a saisi pendant le parcours d'entrée.
@freezed
abstract class EntryDraft with _$EntryDraft {
  const factory EntryDraft({
    @Default(true) bool creatingAccount,
    @Default('id_card') String documentType,
    @Default('BJ') String countryCode,
    @Default(false) bool frontCaptured,
    @Default(false) bool backCaptured,
  }) = _EntryDraft;
}

@Riverpod(keepAlive: true)
class EntryDraftController extends _$EntryDraftController {
  @override
  EntryDraft build() => const EntryDraft();

  void setCreatingAccount(bool value) =>
      state = state.copyWith(creatingAccount: value);

  void setDocument(String documentType, String countryCode) =>
      state = state.copyWith(
        documentType: documentType,
        countryCode: countryCode,
        frontCaptured: false,
        backCaptured: false,
      );

  void markCaptured({required bool front}) => state = front
      ? state.copyWith(frontCaptured: true)
      : state.copyWith(backCaptured: true);
}
