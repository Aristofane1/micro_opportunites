import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/payout.dart';

part 'payout_model.freezed.dart';
part 'payout_model.g.dart';

@freezed
abstract class PayoutModel with _$PayoutModel {
  const PayoutModel._();

  const factory PayoutModel({
    required String id,
    required int amount,
    required int grossAmount,
    required String missionTitle,
    required String posterName,
    required String validatedAt,
    required String commissionLabel,
    required String accountLabel,
    required String reference,
  }) = _PayoutModel;

  factory PayoutModel.fromJson(Map<String, dynamic> json) =>
      _$PayoutModelFromJson(json);

  Payout toEntity() => Payout(
    id: id,
    amount: amount,
    grossAmount: grossAmount,
    missionTitle: missionTitle,
    posterName: posterName,
    validatedAt: DateTime.parse(validatedAt),
    commissionLabel: commissionLabel,
    accountLabel: accountLabel,
    reference: reference,
  );
}
