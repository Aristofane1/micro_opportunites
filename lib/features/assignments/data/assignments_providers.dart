import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/assignments/data/datasources/assignments_remote_data_source.dart';
import 'package:micro_opportunites/features/assignments/data/repositories/assignments_repository_impl.dart';
import 'package:micro_opportunites/features/assignments/domain/repositories/assignments_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignments_providers.g.dart';

@riverpod
AssignmentsRepository assignmentsRepository(Ref ref) =>
    AssignmentsRepositoryImpl(
      AssignmentsRemoteDataSource(ref.watch(apiClientProvider)),
    );
