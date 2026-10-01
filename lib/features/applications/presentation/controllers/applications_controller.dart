import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/applications/data/applications_providers.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/domain/entities/apply_target.dart';
import 'package:micro_opportunites/features/applications/domain/repositories/applications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'applications_controller.g.dart';

@riverpod
Future<List<Application>> myApplications(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(applicationsRepositoryProvider).fetchMyApplications())
      .getOrThrow();
}

@riverpod
Future<Application> applicationDetail(Ref ref, String id) async {
  final all = await ref.watch(myApplicationsProvider.future);
  return all.firstWhere(
    (application) => application.id == id,
    orElse: () => throw const ValidationFailure('Candidature introuvable.'),
  );
}

@riverpod
Future<ApplyTarget> applyTarget(Ref ref, String missionId) async =>
    (await ref
            .watch(applicationsRepositoryProvider)
            .fetchApplyTarget(missionId))
        .getOrThrow();

/// Actions d'écriture. L'état indique si une action est en cours (bouton
/// en chargement) ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
@Riverpod(keepAlive: true)
class ApplicationActions extends _$ApplicationActions {
  @override
  FutureOr<void> build() {}

  Future<Result<Application>> apply({
    required String missionId,
    required String message,
  }) => _run(() => _repository.apply(missionId: missionId, message: message));

  Future<Result<Application>> withdraw(String applicationId) =>
      _run(() => _repository.withdraw(applicationId));

  Future<Result<Application>> confirmOffer(String applicationId) =>
      _run(() => _repository.confirmOffer(applicationId));

  Future<Result<Application>> declineOffer(String applicationId) =>
      _run(() => _repository.declineOffer(applicationId));

  ApplicationsRepository get _repository =>
      ref.read(applicationsRepositoryProvider);

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
