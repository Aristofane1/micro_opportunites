import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_draft_controller.freezed.dart';
part 'entry_draft_controller.g.dart';

/// Ce que l'utilisateur a saisi pendant le parcours d'entrée.
@freezed
abstract class EntryDraft with _$EntryDraft {
  const factory EntryDraft({
    String? phone,
    PhoneVerification? verification,
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

  void setVerification(String phone, PhoneVerification verification) =>
      state = state.copyWith(phone: phone, verification: verification);

  void setDocument(String documentType, String countryCode) => state = state.copyWith(
    documentType: documentType,
    countryCode: countryCode,
    frontCaptured: false,
    backCaptured: false,
  );

  void markCaptured({required bool front}) => state = front
      ? state.copyWith(frontCaptured: true)
      : state.copyWith(backCaptured: true);
}
