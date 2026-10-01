import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/missions/data/datasources/missions_remote_data_source.dart';
import 'package:micro_opportunites/features/missions/data/repositories/missions_repository_impl.dart';
import 'package:micro_opportunites/features/missions/domain/repositories/missions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'missions_providers.g.dart';

@riverpod
MissionsRepository missionsRepository(Ref ref) => MissionsRepositoryImpl(
  MissionsRemoteDataSource(ref.watch(apiClientProvider)),
);
