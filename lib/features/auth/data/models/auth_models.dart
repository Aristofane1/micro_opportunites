import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class PhoneVerificationModel with _$PhoneVerificationModel {
  const PhoneVerificationModel._();

  const factory PhoneVerificationModel({
    required String requestId,
    required String demoCode,
    required String maskedPhone,
  }) = _PhoneVerificationModel;

  factory PhoneVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneVerificationModelFromJson(json);

  PhoneVerification toEntity() => PhoneVerification(
    requestId: requestId,
    demoCode: demoCode,
    maskedPhone: maskedPhone,
  );
}

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String firstName,
    required String lastName,
    required String birthDate,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  UserProfile toEntity() => UserProfile(
    firstName: firstName,
    lastName: lastName,
    birthDate: DateTime.parse(birthDate),
  );
}

@freezed
abstract class KycStateModel with _$KycStateModel {
  const KycStateModel._();

  const factory KycStateModel({required String status, String? submittedAt}) =
      _KycStateModel;

  factory KycStateModel.fromJson(Map<String, dynamic> json) =>
      _$KycStateModelFromJson(json);

  KycState toEntity() => KycState(
    status: KycStatus.fromApi(status),
    submittedAt: submittedAt == null ? null : DateTime.parse(submittedAt!),
  );
}
