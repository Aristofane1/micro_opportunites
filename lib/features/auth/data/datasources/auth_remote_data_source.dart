import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/auth/data/models/auth_models.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);

  final ApiClient _api;

  Future<PhoneVerificationModel> requestCode(String phone) async =>
      PhoneVerificationModel.fromJson(
        await _api.post('/auth/phone', body: {'phone': phone})
            as Map<String, dynamic>,
      );

  Future<void> verifyCode(String requestId, String code) =>
      _api.post('/auth/otp', body: {'requestId': requestId, 'code': code});

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
