import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/auth/data/auth_providers.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/domain/repositories/auth_repository.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
Future<KycState> kycState(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(authRepositoryProvider).fetchKycState()).getOrThrow();
}

/// Actions du parcours d'entrée. Gardé en vie : en autoDispose, le
/// notifier peut être détruit pendant l'appel réseau.
@Riverpod(keepAlive: true)
class AuthActions extends _$AuthActions {
  @override
  FutureOr<void> build() {}

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<Result<PhoneVerification>> requestCode(String phone) async {
    final result = await _run(() => _repository.requestCode(phone));
    if (result case Success(:final value)) {
      ref
          .read(entryDraftControllerProvider.notifier)
          .setVerification(phone, value);
    }
    return result;
  }

  Future<Result<void>> verifyCode(String code) {
    final requestId = ref
        .read(entryDraftControllerProvider)
        .verification
        ?.requestId;
    if (requestId == null) {
      return Future.value(
        const Err(ValidationFailure('Demandez d’abord un code.')),
      );
    }
    return _run(() => _repository.verifyCode(requestId: requestId, code: code));
  }

  Future<Result<UserProfile>> saveProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required bool acceptTerms,
    required bool acceptNewsletter,
  }) => _run(
    () => _repository.saveProfile(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      acceptTerms: acceptTerms,
      acceptNewsletter: acceptNewsletter,
    ),
  );

  Future<Result<KycState>> submitKyc() {
    final draft = ref.read(entryDraftControllerProvider);
    return _run(
      () => _repository.submitKyc(
        documentType: draft.documentType,
        countryCode: draft.countryCode,
        frontCaptured: draft.frontCaptured,
        backCaptured: draft.backCaptured,
      ),
    );
  }

  Future<Result<T>> _run<T>(Future<Result<T>> Function() action) async {
    state = const AsyncLoading();
    final result = await action();
    if (!ref.mounted) return result;
    state = switch (result) {
      Success() => const AsyncData(null),
      Err(:final failure) => AsyncError(failure, StackTrace.current),
    };
    if (result.isSuccess) ref.read(dataRevisionProvider.notifier).bump();
    return result;
  }
}
