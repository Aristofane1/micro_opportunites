import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/earnings/data/earnings_providers.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/payout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earnings_controller.g.dart';

@riverpod
Future<EarningsSummary> earningsSummary(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(earningsRepositoryProvider).fetchSummary())
      .getOrThrow();
}

@riverpod
Future<Payout> payout(Ref ref, String id) async =>
    (await ref.watch(earningsRepositoryProvider).fetchPayout(id)).getOrThrow();
