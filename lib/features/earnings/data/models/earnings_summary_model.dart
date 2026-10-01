import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';

part 'earnings_summary_model.freezed.dart';
part 'earnings_summary_model.g.dart';

/// JSON de `GET /me/earnings`.
@freezed
abstract class EarningsSummaryModel with _$EarningsSummaryModel {
  const EarningsSummaryModel._();

  const factory EarningsSummaryModel({
    required AmountCountModel upcoming,
    required PaidTotalModel paid,
    required PayoutAccountModel payoutAccount,
    required List<EarningLineModel> lines,
  }) = _EarningsSummaryModel;

  factory EarningsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$EarningsSummaryModelFromJson(json);

  EarningsSummary toEntity() => EarningsSummary(
    upcomingAmount: upcoming.amount,
    upcomingCount: upcoming.count,
    paidAmount: paid.amount,
    paidCount: paid.count,
    paidPeriodLabel: paid.periodLabel,
    payoutAccount: PayoutAccount(
      operator: payoutAccount.operator,
      maskedNumber: payoutAccount.maskedNumber,
      holderName: payoutAccount.holderName,
    ),
    lines: [for (final line in lines) line.toEntity()],
  );
}

@freezed
abstract class AmountCountModel with _$AmountCountModel {
  const factory AmountCountModel({required int amount, required int count}) =
      _AmountCountModel;

  factory AmountCountModel.fromJson(Map<String, dynamic> json) =>
      _$AmountCountModelFromJson(json);
}

@freezed
abstract class PaidTotalModel with _$PaidTotalModel {
  const factory PaidTotalModel({
    required int amount,
    required int count,
    required String periodLabel,
  }) = _PaidTotalModel;

  factory PaidTotalModel.fromJson(Map<String, dynamic> json) =>
      _$PaidTotalModelFromJson(json);
}

@freezed
abstract class PayoutAccountModel with _$PayoutAccountModel {
  const factory PayoutAccountModel({
    required String operator,
    required String maskedNumber,
    required String holderName,
  }) = _PayoutAccountModel;

  factory PayoutAccountModel.fromJson(Map<String, dynamic> json) =>
      _$PayoutAccountModelFromJson(json);
}

@freezed
abstract class EarningLineModel with _$EarningLineModel {
  const EarningLineModel._();

  const factory EarningLineModel({
    required String id,
    required String title,
    required String status,
    required String date,
    required int amount,
    String? payoutId,
  }) = _EarningLineModel;

  factory EarningLineModel.fromJson(Map<String, dynamic> json) =>
      _$EarningLineModelFromJson(json);

  EarningLine toEntity() => EarningLine(
    id: id,
    title: title,
    status: EarningStatus.fromApi(status),
    date: DateTime.parse(date),
    amount: amount,
    payoutId: payoutId,
  );
}
