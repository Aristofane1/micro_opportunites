// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneVerificationModel _$PhoneVerificationModelFromJson(
  Map<String, dynamic> json,
) => _PhoneVerificationModel(
  requestId: json['requestId'] as String,
  demoCode: json['demoCode'] as String,
  maskedPhone: json['maskedPhone'] as String,
);

Map<String, dynamic> _$PhoneVerificationModelToJson(
  _PhoneVerificationModel instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'demoCode': instance.demoCode,
  'maskedPhone': instance.maskedPhone,
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
