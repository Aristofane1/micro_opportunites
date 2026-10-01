import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/applications/data/datasources/applications_remote_data_source.dart';
import 'package:micro_opportunites/features/applications/data/repositories/applications_repository_impl.dart';
import 'package:micro_opportunites/features/applications/domain/repositories/applications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'applications_providers.g.dart';

@riverpod
ApplicationsRepository applicationsRepository(Ref ref) =>
    ApplicationsRepositoryImpl(
      ApplicationsRemoteDataSource(ref.watch(apiClientProvider)),
    );
