// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarningsSummaryModel _$EarningsSummaryModelFromJson(
  Map<String, dynamic> json,
) => _EarningsSummaryModel(
  upcoming: AmountCountModel.fromJson(json['upcoming'] as Map<String, dynamic>),
  paid: PaidTotalModel.fromJson(json['paid'] as Map<String, dynamic>),
  payoutAccount: PayoutAccountModel.fromJson(
    json['payoutAccount'] as Map<String, dynamic>,
  ),
  lines: (json['lines'] as List<dynamic>)
      .map((e) => EarningLineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EarningsSummaryModelToJson(
  _EarningsSummaryModel instance,
) => <String, dynamic>{
  'upcoming': instance.upcoming,
  'paid': instance.paid,
  'payoutAccount': instance.payoutAccount,
  'lines': instance.lines,
};

_AmountCountModel _$AmountCountModelFromJson(Map<String, dynamic> json) =>
    _AmountCountModel(
      amount: (json['amount'] as num).toInt(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$AmountCountModelToJson(_AmountCountModel instance) =>
    <String, dynamic>{'amount': instance.amount, 'count': instance.count};

_PaidTotalModel _$PaidTotalModelFromJson(Map<String, dynamic> json) =>
    _PaidTotalModel(
      amount: (json['amount'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      periodLabel: json['periodLabel'] as String,
    );

Map<String, dynamic> _$PaidTotalModelToJson(_PaidTotalModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'count': instance.count,
      'periodLabel': instance.periodLabel,
    };

_PayoutAccountModel _$PayoutAccountModelFromJson(Map<String, dynamic> json) =>
    _PayoutAccountModel(
      operator: json['operator'] as String,
      maskedNumber: json['maskedNumber'] as String,
      holderName: json['holderName'] as String,
    );

Map<String, dynamic> _$PayoutAccountModelToJson(_PayoutAccountModel instance) =>
    <String, dynamic>{
      'operator': instance.operator,
      'maskedNumber': instance.maskedNumber,
      'holderName': instance.holderName,
    };

_EarningLineModel _$EarningLineModelFromJson(Map<String, dynamic> json) =>
    _EarningLineModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toInt(),
      payoutId: json['payoutId'] as String?,
    );

Map<String, dynamic> _$EarningLineModelToJson(_EarningLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'date': instance.date,
      'amount': instance.amount,
      'payoutId': instance.payoutId,
    };
