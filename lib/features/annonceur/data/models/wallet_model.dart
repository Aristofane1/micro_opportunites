import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/wallet.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

/// JSON du portefeuille de l'annonceur (`GET /me/wallet`).
@freezed
abstract class WalletModel with _$WalletModel {
  const WalletModel._();

  const factory WalletModel({
    required int balance,
    required int available,
    required List<BlockedAmountModel> blocked,
    required List<PosterPayoutModel> payouts,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Wallet toEntity() => Wallet(
    balance: balance,
    available: available,
    blocked: [for (final b in blocked) b.toEntity()],
    payouts: [for (final p in payouts) p.toEntity()],
  );
}

@freezed
abstract class BlockedAmountModel with _$BlockedAmountModel {
  const BlockedAmountModel._();

  const factory BlockedAmountModel({
    required String missionId,
    required String title,
    required int amount,
  }) = _BlockedAmountModel;

  factory BlockedAmountModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedAmountModelFromJson(json);

  BlockedAmount toEntity() =>
      BlockedAmount(missionId: missionId, title: title, amount: amount);
}

@freezed
abstract class PosterPayoutModel with _$PosterPayoutModel {
  const PosterPayoutModel._();

  const factory PosterPayoutModel({
    required String id,
    required String missionTitle,
    required String workerName,
    required int amount,
    required String paidAt,
  }) = _PosterPayoutModel;

  factory PosterPayoutModel.fromJson(Map<String, dynamic> json) =>
      _$PosterPayoutModelFromJson(json);

  PosterPayout toEntity() => PosterPayout(
    id: id,
    missionTitle: missionTitle,
    workerName: workerName,
    amount: amount,
    paidAt: DateTime.parse(paidAt),
  );
}
