import 'package:freezed_annotation/freezed_annotation.dart';

part 'payout.freezed.dart';

@freezed
abstract class Payout with _$Payout {
  const factory Payout({
    required String id,
    required int amount,
    required int grossAmount,
    required String missionTitle,
    required String posterName,
    required DateTime validatedAt,
    required String commissionLabel,
    required String accountLabel,
    required String reference,
  }) = _Payout;
}
