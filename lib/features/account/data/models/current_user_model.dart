import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/account/domain/entities/current_user.dart';

part 'current_user_model.freezed.dart';
part 'current_user_model.g.dart';

/// Réponse JSON de `GET /me`.
@freezed
abstract class CurrentUserModel with _$CurrentUserModel {
  const CurrentUserModel._();

  const factory CurrentUserModel({
    required String id,
    required String firstName,
    required String city,
  }) = _CurrentUserModel;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserModelFromJson(json);

  CurrentUser toEntity() =>
      CurrentUser(id: id, firstName: firstName, city: city);
}
