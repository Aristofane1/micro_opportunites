import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/alerts/data/datasources/alerts_remote_data_source.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';
import 'package:micro_opportunites/features/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  AlertsRepositoryImpl(this._remote);

  final AlertsRemoteDataSource _remote;

  @override
  Future<Result<List<MissionAlert>>> fetchAlerts() => guardResult(
    () async => [for (final m in await _remote.fetchAlerts()) m.toEntity()],
  );

  @override
  Future<Result<MissionAlert>> createAlert(AlertDraft draft) =>
      guardResult(() async => (await _remote.create(draft)).toEntity());

  @override
  Future<Result<void>> deleteAlert(String id) =>
      guardResult(() => _remote.delete(id));
}
