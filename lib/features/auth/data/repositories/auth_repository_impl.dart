import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

  @override
  Future<Result<Account>> login({
    required String email,
    required String password,
  }) => guardResult(
    () async => (await _remote.login(email, password)).toEntity(),
  );

  @override
  Future<Result<Account>> signup({
    required String email,
    required String password,
  }) => guardResult(
    () async => (await _remote.signup(email, password)).toEntity(),
  );

  @override
  Future<Result<void>> logout() => guardResult(_remote.logout);

  @override
  Future<Result<UserProfile>> saveProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required bool acceptTerms,
    required bool acceptNewsletter,
  }) => guardResult(
    () async => (await _remote.saveProfile({
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String().substring(0, 10),
      'acceptTerms': acceptTerms,
      'acceptNewsletter': acceptNewsletter,
    })).toEntity(),
  );

  @override
  Future<Result<KycState>> submitKyc({
    required String documentType,
    required String countryCode,
    required bool frontCaptured,
    required bool backCaptured,
  }) => guardResult(
    () async => (await _remote.submitKyc({
      'documentType': documentType,
      'countryCode': countryCode,
      'frontCaptured': frontCaptured,
      'backCaptured': backCaptured,
    })).toEntity(),
  );

  @override
  Future<Result<KycState>> fetchKycState() =>
      guardResult(() async => (await _remote.fetchKycState()).toEntity());
}
