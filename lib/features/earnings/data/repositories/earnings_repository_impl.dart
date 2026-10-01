import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/earnings/data/datasources/earnings_remote_data_source.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/payout.dart';
import 'package:micro_opportunites/features/earnings/domain/repositories/earnings_repository.dart';

class EarningsRepositoryImpl implements EarningsRepository {
  EarningsRepositoryImpl(this._remote);

  final EarningsRemoteDataSource _remote;

  @override
  Future<Result<EarningsSummary>> fetchSummary() =>
      guardResult(() async => (await _remote.fetchSummary()).toEntity());

  @override
  Future<Result<Payout>> fetchPayout(String id) =>
      guardResult(() async => (await _remote.fetchPayout(id)).toEntity());
}
