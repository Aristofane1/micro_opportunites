// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PayoutModel _$PayoutModelFromJson(Map<String, dynamic> json) => _PayoutModel(
  id: json['id'] as String,
  amount: (json['amount'] as num).toInt(),
  grossAmount: (json['grossAmount'] as num).toInt(),
  missionTitle: json['missionTitle'] as String,
  posterName: json['posterName'] as String,
  validatedAt: json['validatedAt'] as String,
  commissionLabel: json['commissionLabel'] as String,
  accountLabel: json['accountLabel'] as String,
  reference: json['reference'] as String,
);

Map<String, dynamic> _$PayoutModelToJson(_PayoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'grossAmount': instance.grossAmount,
      'missionTitle': instance.missionTitle,
      'posterName': instance.posterName,
      'validatedAt': instance.validatedAt,
      'commissionLabel': instance.commissionLabel,
      'accountLabel': instance.accountLabel,
      'reference': instance.reference,
    };
