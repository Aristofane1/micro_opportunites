import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entities.freezed.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    required String id,
    required String email,
    required String firstName,
    required String city,
    String? role,
  }) = _Account;
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
  }) = _UserProfile;
}

enum KycStatus {
  none('none'),
  pending('pending');

  const KycStatus(this.apiValue);

  final String apiValue;

  static KycStatus fromApi(String value) =>
      values.firstWhere((s) => s.apiValue == value, orElse: () => none);
}

@freezed
abstract class KycState with _$KycState {
  const factory KycState({required KycStatus status, DateTime? submittedAt}) =
      _KycState;
}
