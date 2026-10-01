import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';

abstract interface class AuthRepository {
  Future<Result<PhoneVerification>> requestCode(String phone);

  Future<Result<void>> verifyCode({
    required String requestId,
    required String code,
  });

  Future<Result<UserProfile>> saveProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required bool acceptTerms,
    required bool acceptNewsletter,
  });

  Future<Result<KycState>> submitKyc({
    required String documentType,
    required String countryCode,
    required bool frontCaptured,
    required bool backCaptured,
  });

  Future<Result<KycState>> fetchKycState();
}
