// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentUserModel _$CurrentUserModelFromJson(Map<String, dynamic> json) =>
    _CurrentUserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      city: json['city'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$CurrentUserModelToJson(_CurrentUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'city': instance.city,
      'role': instance.role,
    };
