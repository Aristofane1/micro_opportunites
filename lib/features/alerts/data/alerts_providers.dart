import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/alerts/data/datasources/alerts_remote_data_source.dart';
import 'package:micro_opportunites/features/alerts/data/repositories/alerts_repository_impl.dart';
import 'package:micro_opportunites/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alerts_providers.g.dart';

@riverpod
AlertsRepository alertsRepository(Ref ref) =>
    AlertsRepositoryImpl(AlertsRemoteDataSource(ref.watch(apiClientProvider)));
