import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/alerts/data/alerts_providers.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';
import 'package:micro_opportunites/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alerts_controller.g.dart';

@riverpod
Future<List<MissionAlert>> myAlerts(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(alertsRepositoryProvider).fetchAlerts()).getOrThrow();
}

/// keepAlive : sans abonné, le notifier serait détruit pendant l'action.
@Riverpod(keepAlive: true)
class AlertActions extends _$AlertActions {
  @override
  FutureOr<void> build() {}

  Future<Result<MissionAlert>> create(AlertDraft draft) =>
      _run(() => _repository.createAlert(draft));

  Future<Result<void>> delete(String id) =>
      _run(() => _repository.deleteAlert(id));

  AlertsRepository get _repository => ref.read(alertsRepositoryProvider);

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
