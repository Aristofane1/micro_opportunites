import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/account/data/datasources/account_remote_data_source.dart';
import 'package:micro_opportunites/features/account/domain/entities/current_user.dart';
import 'package:micro_opportunites/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._remote);

  final AccountRemoteDataSource _remote;

  @override
  Future<Result<CurrentUser>> fetchCurrentUser() =>
      guardResult(() async => (await _remote.fetchMe()).toEntity());
}
