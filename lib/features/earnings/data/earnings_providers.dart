import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/earnings/data/datasources/earnings_remote_data_source.dart';
import 'package:micro_opportunites/features/earnings/data/repositories/earnings_repository_impl.dart';
import 'package:micro_opportunites/features/earnings/domain/repositories/earnings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earnings_providers.g.dart';

@riverpod
EarningsRepository earningsRepository(Ref ref) => EarningsRepositoryImpl(
  EarningsRemoteDataSource(ref.watch(apiClientProvider)),
);
