import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_draft_controller.freezed.dart';
part 'entry_draft_controller.g.dart';

/// Prises de vue de la vérification d'identité.
enum KycShot {
  front,
  back,
  selfie;

  /// Étapes dans l'ordre : recto, verso (sauf passeport), puis selfie.
  static List<KycShot> stepsFor(String documentType) =>
      documentType == 'passport'
      ? const [front, selfie]
      : const [front, back, selfie];
}

/// Ce que l'utilisateur a saisi pendant le parcours d'entrée. Les photos sont
/// des chemins de fichiers locaux.
@freezed
abstract class EntryDraft with _$EntryDraft {
  const factory EntryDraft({
    @Default(true) bool creatingAccount,
    @Default('id_card') String documentType,
    @Default('BJ') String countryCode,
    String? frontPath,
    String? backPath,
    String? selfiePath,
  }) = _EntryDraft;
}

@Riverpod(keepAlive: true)
class EntryDraftController extends _$EntryDraftController {
  @override
  EntryDraft build() => const EntryDraft();

  void setCreatingAccount(bool value) =>
      state = state.copyWith(creatingAccount: value);

  /// Nouvelle pièce : les photos déjà prises sont oubliées.
  void setDocument(String documentType, String countryCode) =>
      state = state.copyWith(
        documentType: documentType,
        countryCode: countryCode,
        frontPath: null,
        backPath: null,
        selfiePath: null,
      );

  void setPhoto(KycShot shot, String path) => state = switch (shot) {
    KycShot.front => state.copyWith(frontPath: path),
    KycShot.back => state.copyWith(backPath: path),
    KycShot.selfie => state.copyWith(selfiePath: path),
  };
}
