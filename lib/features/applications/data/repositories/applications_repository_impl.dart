import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/applications/data/datasources/applications_remote_data_source.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/domain/entities/apply_target.dart';
import 'package:micro_opportunites/features/applications/domain/repositories/applications_repository.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  ApplicationsRepositoryImpl(this._remote);

  final ApplicationsRemoteDataSource _remote;

  @override
  Future<Result<List<Application>>> fetchMyApplications() => guardResult(
    () async => [
      for (final m in await _remote.fetchMyApplications()) m.toEntity(),
    ],
  );

  @override
  Future<Result<ApplyTarget>> fetchApplyTarget(String missionId) => guardResult(
    () async => (await _remote.fetchApplyTarget(missionId)).toEntity(),
  );

  @override
  Future<Result<Application>> apply({
    required String missionId,
    required String message,
  }) => guardResult(
    () async => (await _remote.apply(missionId, message)).toEntity(),
  );

  @override
  Future<Result<Application>> withdraw(String applicationId) => guardResult(
    () async => (await _remote.withdraw(applicationId)).toEntity(),
  );

  @override
  Future<Result<Application>> confirmOffer(String applicationId) => guardResult(
    () async => (await _remote.confirm(applicationId)).toEntity(),
  );

  @override
  Future<Result<Application>> declineOffer(String applicationId) => guardResult(
    () async => (await _remote.decline(applicationId)).toEntity(),
  );
}
