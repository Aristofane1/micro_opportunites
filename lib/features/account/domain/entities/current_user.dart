import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user.freezed.dart';

@freezed
abstract class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String id,
    required String firstName,
    required String city,
    String? role,
  }) = _CurrentUser;
}
