import 'fake_database.dart';

const offerValidity = Duration(hours: 12);
const autoPayDelay = Duration(hours: 48);

/// Applique les échéances : offres expirées, versements automatiques,
/// clôture du recrutement des missions commencées.
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
  for (final mission in db.missions.values) {
    if (_recruitmentToClose(mission, now)) _closeRecruitment(db, mission);
  }
}

/// Mission commencée encore ouverte, ou close mais dont une place s'est
/// libérée depuis (désistement).
bool _recruitmentToClose(Json mission, DateTime now) {
  if (DateTime.parse(mission['startAt'] as String).isAfter(now)) return false;
  return mission['status'] == 'published' ||
      (mission['status'] == 'filled' && (mission['slotsFree'] as int) > 0);
}

/// Clôture du recrutement : candidatures en attente refusées, offres
/// expirées ; sans affectation, la mission est annulée et tout son montant
/// bloqué libéré ; sinon les places vides sont débloquées et la mission
/// passe « filled » sans place libre (idempotent).
void _closeRecruitment(FakeDatabase db, Json mission) {
  final id = mission['id'] as String;
  for (final application in db.applications.values.where(
    (a) => a['missionId'] == id,
  )) {
    final status = application['status'];
    if (status == 'pending' || status == 'pending_sync') {
      application['status'] = 'rejected';
    } else if (status == 'offered') {
      application['status'] = 'expired';
    }
  }
  final blocked =
      db.wallets[mission['posterId']]?['blocked'] as Map<String, int>?;
  final staffed = db.assignments.values.any(
    (a) => a['missionId'] == id && a['status'] != 'cancelled',
  );
  if (!staffed) {
    mission['status'] = 'cancelled';
    blocked?.remove(id);
    return;
  }
  if (blocked != null) {
    final amount = blocked[id] ?? 0;
    final free = (mission['slotAmount'] as int) * (mission['slotsFree'] as int);
    final released = free < amount ? free : amount;
    if (released > 0 && released == amount) {
      blocked.remove(id);
    } else if (released > 0) {
      blocked[id] = amount - released;
    }
  }
  mission['status'] = 'filled';
  mission['slotsFree'] = 0;
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
