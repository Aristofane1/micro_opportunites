// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      city: json['city'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'city': instance.city,
      'role': instance.role,
    };

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: json['birthDate'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
    };

_KycStateModel _$KycStateModelFromJson(Map<String, dynamic> json) =>
    _KycStateModel(
      status: json['status'] as String,
      submittedAt: json['submittedAt'] as String?,
    );

Map<String, dynamic> _$KycStateModelToJson(_KycStateModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'submittedAt': instance.submittedAt,
    };
