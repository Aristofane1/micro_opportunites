import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/account/data/datasources/account_remote_data_source.dart';
import 'package:micro_opportunites/features/account/data/repositories/account_repository_impl.dart';
import 'package:micro_opportunites/features/account/domain/repositories/account_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_providers.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) => AccountRepositoryImpl(
  AccountRemoteDataSource(ref.watch(apiClientProvider)),
);
