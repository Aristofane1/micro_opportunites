import 'package:micro_opportunites/dev/fake_api/fake_database.dart';

const offerValidity = Duration(hours: 12);
const autoPayDelay = Duration(hours: 48);

/// Applique les échéances : offres expirées, versements automatiques.
/// Appelée avant chaque requête, idempotente.
void settle(FakeDatabase db, DateTime now) {
  for (final application in db.applications.values) {
    final expires = application['offerExpiresAt'] as String?;
    if (application['status'] == 'offered' &&
        expires != null &&
        !DateTime.parse(expires).isAfter(now)) {
      application['status'] = 'expired';
    }
  }
  for (final assignment in db.assignments.values) {
    final due = assignment['autoValidateAt'] as String?;
    if (assignment['status'] == 'submitted' &&
        due != null &&
        !DateTime.parse(due).isAfter(now)) {
      payAssignment(db, assignment, now);
    }
  }
}

/// Verse le montant de l'affectation : débloque chez l'annonceur, crée le
/// reçu de l'exécutant. Sans effet si déjà payée.
void payAssignment(FakeDatabase db, Json assignment, DateTime now) {
  if (assignment['status'] == 'paid') return;
  final mission = db.missions[assignment['missionId']]!;
  final missionId = mission['id'] as String;
  final posterId = mission['posterId'] as String;
  final amount = assignment['payAmount'] as int;
  final wallet = db.wallets[posterId];
  if (wallet != null) {
    wallet['balance'] = (wallet['balance'] as int) - amount;
    final blocked = wallet['blocked'] as Map<String, int>;
    final left = (blocked[missionId] ?? 0) - amount;
    if (left < 0) {
      throw StateError(
        'Montant bloqué insuffisant pour $missionId : $amount à verser.',
      );
    }
    if (left == 0) {
      blocked.remove(missionId);
    } else {
      blocked[missionId] = left;
    }
  }
  final worker = db.users[assignment['workerId']]!;
  final account = worker['payoutAccount'] as Json;
  final id = db.newId('po');
  db.payouts[id] = {
    'id': id,
    'workerId': assignment['workerId'],
    'posterId': posterId,
    'assignmentId': assignment['id'],
    'amount': amount,
    'grossAmount': amount,
    'missionTitle': mission['title'],
    'posterName': db.posters[posterId]?['displayName'] ?? '',
    'validatedAt': now.toUtc().toIso8601String(),
    'commissionLabel': 'Aucune (démo)',
    'accountLabel':
        '${account['operator']} · •• ${(account['maskedNumber'] as String).split(' ').last}',
    'reference': 'MO-${now.year}-${id.substring(2).padLeft(6, '0')}',
    'status': 'paid',
  };
  assignment['status'] = 'paid';
  assignment['payoutId'] = id;
}
