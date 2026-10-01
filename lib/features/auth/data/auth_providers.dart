import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:micro_opportunites/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:micro_opportunites/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(AuthRemoteDataSource(ref.watch(apiClientProvider)));
