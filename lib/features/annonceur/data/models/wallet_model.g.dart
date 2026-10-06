// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => _WalletModel(
  balance: (json['balance'] as num).toInt(),
  available: (json['available'] as num).toInt(),
  blocked: (json['blocked'] as List<dynamic>)
      .map((e) => BlockedAmountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  payouts: (json['payouts'] as List<dynamic>)
      .map((e) => PosterPayoutModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WalletModelToJson(_WalletModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'available': instance.available,
      'blocked': instance.blocked,
      'payouts': instance.payouts,
    };

_BlockedAmountModel _$BlockedAmountModelFromJson(Map<String, dynamic> json) =>
    _BlockedAmountModel(
      missionId: json['missionId'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$BlockedAmountModelToJson(_BlockedAmountModel instance) =>
    <String, dynamic>{
      'missionId': instance.missionId,
      'title': instance.title,
      'amount': instance.amount,
    };

_PosterPayoutModel _$PosterPayoutModelFromJson(Map<String, dynamic> json) =>
    _PosterPayoutModel(
      id: json['id'] as String,
      missionTitle: json['missionTitle'] as String,
      workerName: json['workerName'] as String,
      amount: (json['amount'] as num).toInt(),
      paidAt: json['paidAt'] as String,
    );

Map<String, dynamic> _$PosterPayoutModelToJson(_PosterPayoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'missionTitle': instance.missionTitle,
      'workerName': instance.workerName,
      'amount': instance.amount,
      'paidAt': instance.paidAt,
    };
