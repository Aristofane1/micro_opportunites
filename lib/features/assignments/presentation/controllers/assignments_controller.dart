import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/assignments/data/assignments_providers.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/domain/repositories/assignments_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignments_controller.g.dart';

@riverpod
Future<Assignment> assignment(Ref ref, String id) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(assignmentsRepositoryProvider).fetchAssignment(id))
      .getOrThrow();
}

/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
@Riverpod(keepAlive: true)
class AssignmentActions extends _$AssignmentActions {
  @override
  FutureOr<void> build() {}

  Future<Result<Assignment>> checkIn(Assignment assignment) {
    return _run(() async {
      final position = await ref
          .read(locationServiceProvider)
          .currentPosition(
            expected: (
              latitude: assignment.latitude,
              longitude: assignment.longitude,
            ),
          );
      return _repository.checkIn(
        assignment.id,
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  Future<Result<Assignment>> checkOut(
    String id, {
    required String note,
    required List<String> photos,
  }) => _run(() => _repository.checkOut(id, note: note, photos: photos));

  Future<Result<Assignment>> withdraw(String id) =>
      _run(() => _repository.withdraw(id));

  AssignmentsRepository get _repository =>
      ref.read(assignmentsRepositoryProvider);

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
