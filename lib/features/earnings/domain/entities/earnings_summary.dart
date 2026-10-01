import 'package:freezed_annotation/freezed_annotation.dart';

part 'earnings_summary.freezed.dart';

enum EarningStatus {
  reserved('reserved'),
  awaitingValidation('awaiting_validation'),
  paid('paid');

  const EarningStatus(this.apiValue);

  final String apiValue;

  static EarningStatus fromApi(String value) =>
      values.firstWhere((s) => s.apiValue == value, orElse: () => reserved);
}

@freezed
abstract class EarningLine with _$EarningLine {
  const factory EarningLine({
    required String id,
    required String title,
    required EarningStatus status,
    required DateTime date,
    required int amount,
    String? payoutId,
  }) = _EarningLine;
}

@freezed
abstract class PayoutAccount with _$PayoutAccount {
  const factory PayoutAccount({
    required String operator,
    required String maskedNumber,
    required String holderName,
  }) = _PayoutAccount;
}

@freezed
abstract class EarningsSummary with _$EarningsSummary {
  const factory EarningsSummary({
    required int upcomingAmount,
    required int upcomingCount,
    required int paidAmount,
    required int paidCount,
    required String paidPeriodLabel,
    required PayoutAccount payoutAccount,
    required List<EarningLine> lines,
  }) = _EarningsSummary;
}
