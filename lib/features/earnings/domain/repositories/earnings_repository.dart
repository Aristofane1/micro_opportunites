import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/payout.dart';

abstract interface class EarningsRepository {
  Future<Result<EarningsSummary>> fetchSummary();

  Future<Result<Payout>> fetchPayout(String id);
}
