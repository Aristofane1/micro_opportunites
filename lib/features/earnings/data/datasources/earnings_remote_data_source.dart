import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/earnings/data/models/earnings_summary_model.dart';
import 'package:micro_opportunites/features/earnings/data/models/payout_model.dart';

class EarningsRemoteDataSource {
  EarningsRemoteDataSource(this._api);

  final ApiClient _api;

  Future<EarningsSummaryModel> fetchSummary() async =>
      EarningsSummaryModel.fromJson(
        await _api.get('/me/earnings') as Map<String, dynamic>,
      );

  Future<PayoutModel> fetchPayout(String id) async => PayoutModel.fromJson(
    await _api.get('/me/payouts/$id') as Map<String, dynamic>,
  );
}
