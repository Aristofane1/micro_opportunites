import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/auth/data/models/auth_models.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);

  final ApiClient _api;

  Future<AccountModel> login(String email, String password) async =>
      AccountModel.fromJson(
        await _api.post(
              '/auth/login',
              body: {'email': email, 'password': password},
            )
            as Map<String, dynamic>,
      );

  Future<AccountModel> signup(String email, String password) async =>
      AccountModel.fromJson(
        await _api.post(
              '/auth/signup',
              body: {'email': email, 'password': password},
            )
            as Map<String, dynamic>,
      );

  Future<void> logout() => _api.post('/auth/logout');

  Future<UserProfileModel> saveProfile(Map<String, Object?> body) async =>
      UserProfileModel.fromJson(
        await _api.post('/auth/profile', body: body) as Map<String, dynamic>,
      );

  Future<KycStateModel> submitKyc(Map<String, Object?> body) async =>
      KycStateModel.fromJson(
        await _api.post('/auth/kyc', body: body) as Map<String, dynamic>,
      );

  Future<KycStateModel> fetchKycState() async => KycStateModel.fromJson(
    await _api.get('/auth/kyc') as Map<String, dynamic>,
  );
}
