import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';

Object? getEarnings(FakeDatabase db, FakeRequest request) {
  final lines = <Json>[];
  var upcomingAmount = 0;
  var upcomingCount = 0;
  for (final a in db.assignments.values.where(
    (a) => a['workerId'] == db.currentUserId,
  )) {
    final status = switch (a['status']) {
      'confirmed' || 'in_progress' => 'reserved',
      'submitted' => 'awaiting_validation',
      _ => null,
    };
    if (status == null) continue;
    upcomingAmount += a['payAmount'] as int;
    upcomingCount++;
    lines.add({
      'id': 'l-${a['id']}',
      'title': a['title'],
      'status': status,
      'date': status == 'reserved' ? a['startAt'] : a['checkOutAt'],
      'amount': a['payAmount'],
      'payoutId': null,
    });
  }
  var paidAmount = 0;
  var paidCount = 0;
  final since = request.now.toUtc().subtract(const Duration(days: 30));
  for (final p in db.payouts.values) {
    final validatedAt = DateTime.parse(p['validatedAt'] as String);
    if (validatedAt.isAfter(since)) {
      paidAmount += p['amount'] as int;
      paidCount++;
    }
    lines.add({
      'id': 'l-${p['id']}',
      'title': p['missionTitle'],
      'status': 'paid',
      'date': p['validatedAt'],
      'amount': p['amount'],
      'payoutId': p['id'],
    });
  }
  lines.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));
  return {
    'upcoming': {'amount': upcomingAmount, 'count': upcomingCount},
    'paid': {
      'amount': paidAmount,
      'count': paidCount,
      'periodLabel': '30 derniers jours',
    },
    'payoutAccount': db.currentUser['payoutAccount'],
    'lines': lines,
  };
}

Object? getPayout(FakeDatabase db, FakeRequest request) {
  final payout = db.payouts[request.params['id']];
  if (payout == null) throw const ApiException(404, 'Reçu introuvable.');
  return payout;
}
