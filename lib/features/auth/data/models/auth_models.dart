import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String id,
    required String email,
    required String firstName,
    required String city,
    String? role,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Account toEntity() => Account(
    id: id,
    email: email,
    firstName: firstName,
    city: city,
    role: role,
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
