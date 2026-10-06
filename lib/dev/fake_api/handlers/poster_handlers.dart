import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';
import 'package:micro_opportunites/dev/fake_api/geo.dart';
import 'package:micro_opportunites/dev/fake_api/settlement.dart';

const _notFound = ApiException(404, 'Mission introuvable.');

/// Mission appartenant au compte connecté, sinon 404.
Json _ownMission(FakeDatabase db, String? id) {
  final mission = db.missions[id];
  if (mission == null || mission['posterId'] != db.currentUserId) {
    throw _notFound;
  }
  return mission;
}

/// Candidature à une mission du compte connecté, sinon 404.
Json _ownApplication(FakeDatabase db, String? id) {
  final application = db.applications[id];
  final mission = db.missions[application?['missionId']];
  if (application == null ||
      mission == null ||
      mission['posterId'] != db.currentUserId) {
    throw const ApiException(404, 'Candidature introuvable.');
  }
  return application;
}

/// Affectation sur une mission du compte connecté, sinon 404.
Json _ownAssignment(FakeDatabase db, String? id) {
  final assignment = db.assignments[id];
  final mission = db.missions[assignment?['missionId']];
  if (assignment == null ||
      mission == null ||
      mission['posterId'] != db.currentUserId) {
    throw _notFound;
  }
  return assignment;
}

Json _wallet(FakeDatabase db) => db.wallets.putIfAbsent(
  db.currentUserId,
  () => {'balance': 0, 'blocked': <String, int>{}},
);

Map<String, int> _blocked(Json wallet) => wallet['blocked'] as Map<String, int>;

int _available(Json wallet) =>
    (wallet['balance'] as int) -
    _blocked(wallet).values.fold(0, (sum, amount) => sum + amount);

Iterable<Json> _applicationsOf(FakeDatabase db, String missionId) =>
    db.applications.values.where((a) => a['missionId'] == missionId);

Iterable<Json> _activeAssignmentsOf(FakeDatabase db, String missionId) => db
    .assignments
    .values
    .where((a) => a['missionId'] == missionId && a['status'] != 'cancelled');

int? _int(Object? value) => value is num ? value.toInt() : null;

double _round2(double value) => (value * 100).round() / 100;

/// Mission vue par son annonceur (B-annonceur « Mes missions »).
Json posterMissionJson(FakeDatabase db, Json mission) {
  final id = mission['id'] as String;
  final applications = _applicationsOf(db, id).toList();
  final assignments = _activeAssignmentsOf(db, id).toList();
  final slotsConfirmed = assignments.length;
  final slotsOffered = applications
      .where((a) => a['status'] == 'offered')
      .length;
  final wallet = db.wallets[mission['posterId']];
  final pay = mission['pay'] as Json;
  final String status;
  if (mission['status'] == 'cancelled') {
    status = 'cancelled';
  } else if (assignments.isNotEmpty &&
      assignments.every((a) => a['status'] == 'paid') &&
      (mission['slotsFree'] as int) <= 0) {
    status = 'completed';
  } else if (assignments.any(
    (a) =>
        const {'in_progress', 'submitted', 'contested'}.contains(a['status']),
  )) {
    status = 'inProgress';
  } else if (slotsConfirmed + slotsOffered > 0) {
    status = 'selected';
  } else {
    status = 'published';
  }
  return {
    'id': id,
    'title': mission['title'],
    'category': mission['category'],
    'city': mission['city'],
    'startAt': mission['startAt'],
    'durationMin': mission['durationMin'],
    'payAmount': pay['amount'],
    'payUnit': pay['type'],
    'slotsTotal': mission['slotsTotal'],
    'slotsConfirmed': slotsConfirmed,
    'slotsOffered': slotsOffered,
    'applicantsCount': applications
        .where((a) => a['status'] != 'withdrawn')
        .length,
    'newApplicantsCount': applications
        .where((a) => a['status'] == 'pending')
        .length,
    'blockedAmount': wallet == null ? 0 : _blocked(wallet)[id] ?? 0,
    'status': status,
  };
}

/// Candidat vu par l'annonceur : profil, statut et présence.
Json candidateJson(FakeDatabase db, Json application) {
  final worker = db.users[application['workerId']]!;
  final profile = (worker['worker'] as Json?) ?? const <String, dynamic>{};
  final assignment = db.assignments[application['assignmentId']];
  final status = switch (application['status']) {
    'pending' || 'pending_sync' => 'pending',
    'offered' => 'retained',
    'confirmed' => 'confirmed',
    _ => 'refused',
  };
  final attendance = switch (assignment?['status']) {
    'in_progress' => 'arrived',
    'submitted' => 'finished',
    'paid' => 'validated',
    'contested' => 'contested',
    _ => 'notArrived',
  };
  return {
    'id': application['id'],
    'workerId': application['workerId'],
    'name': '${worker['firstName']} ${worker['lastName']}',
    'city': worker['city'],
    'memberSince': profile['memberSince'],
    'pitch': profile['pitch'],
    'skills': profile['skills'] ?? const <String>[],
    'verified': profile['verified'] ?? false,
    'rating': profile['rating'],
    'reviewsCount': profile['reviewsCount'] ?? 0,
    'missionsCount': profile['missionsCount'] ?? 0,
    'reliability': profile['reliability'],
    'absences': profile['absences'] ?? 0,
    'status': status,
    'attendance': attendance,
    'assignmentId': assignment?['id'],
    'arrivedAt': assignment?['checkInAt'],
    'finishedAt': assignment?['checkOutAt'],
    'autoPayAt': assignment?['autoValidateAt'],
    'distanceMeters': assignment?['checkInDistanceM'],
    'proofPhotos': (assignment?['photos'] as List?)?.length ?? 0,
    'completionNote': assignment?['note'],
    'offerExpiresAt': application['offerExpiresAt'],
  };
}

Object? publishMission(FakeDatabase db, FakeRequest request) {
  final body = request.body;
  final userId = db.currentUserId;
  if (db.posters[userId] == null) {
    throw const ApiException(403, 'Passez en mode annonceur pour publier.');
  }
  final title = (body['title'] as String? ?? '').trim();
  if (title.isEmpty) {
    throw const ApiException(422, 'Indiquez un titre.');
  }
  final slots = _int(body['slots']) ?? 0;
  if (slots < 1 || slots > 50) {
    throw const ApiException(422, 'Le nombre de places va de 1 à 50.');
  }
  final payAmount = _int(body['payAmount']) ?? 0;
  if (payAmount <= 0) {
    throw const ApiException(422, 'Indiquez la rémunération.');
  }
  final startAt = DateTime.tryParse(body['startAt'] as String? ?? '');
  if (startAt == null || !startAt.isAfter(request.now)) {
    throw const ApiException(422, 'La date de début doit être à venir.');
  }
  final durationMin = _int(body['durationMin']) ?? 0;
  final payUnit = body['payUnit'] as String? ?? 'flat';
  final total = payUnit == 'hourly'
      ? (payAmount * durationMin * slots / 60).round()
      : payAmount * slots;
  final wallet = _wallet(db);
  if (total > _available(wallet)) {
    throw ApiException(
      422,
      'Solde insuffisant pour bloquer ${formatFcfa(total)}.',
    );
  }
  final city = body['city'] as String? ?? '';
  final description = body['description'] as String? ?? '';
  final lat = asDouble(body['lat']);
  final lng = asDouble(body['lng']);
  final deadline = DateTime.tryParse(body['applyDeadline'] as String? ?? '');
  final id = db.newId('m');
  db.missions[id] = {
    'id': id,
    'title': title,
    'category': body['category'] ?? 'other',
    'city': city,
    'zone': {'lat': _round2(lat), 'lng': _round2(lng)},
    'startAt': startAt.toUtc().toIso8601String(),
    'durationMin': durationMin,
    'pay': {'amount': payAmount, 'type': payUnit},
    'slotsTotal': slots,
    'slotsFree': slots,
    'posterId': userId,
    'publishedAt': request.now.toUtc().toIso8601String(),
    'applyDeadline': (deadline ?? startAt).toUtc().toIso8601String(),
    'description': description,
    'status': 'published',
    'publicQuestionsCount': 0,
    'private': {
      'district': city,
      'address': body['address'],
      'landmark': body['landmark'],
      'lat': lat,
      'lng': lng,
      'briefing': description,
    },
  };
  _blocked(wallet)[id] = total;
  return posterMissionJson(db, db.missions[id]!);
}

Object? listMyMissions(FakeDatabase db, FakeRequest request) {
  final mine =
      db.missions.values
          .where((m) => m['posterId'] == db.currentUserId)
          .toList()
        ..sort(
          (a, b) => (b['publishedAt'] as String).compareTo(
            a['publishedAt'] as String,
          ),
        );
  return [for (final m in mine) posterMissionJson(db, m)];
}

Object? getMyMission(FakeDatabase db, FakeRequest request) =>
    posterMissionJson(db, _ownMission(db, request.params['id']));

Object? listCandidates(FakeDatabase db, FakeRequest request) {
  final mission = _ownMission(db, request.params['id']);
  final applications =
      _applicationsOf(
        db,
        mission['id'] as String,
      ).where((a) => a['status'] != 'withdrawn').toList()..sort(
        (a, b) =>
            (a['createdAt'] as String).compareTo(b['createdAt'] as String),
      );
  return [for (final a in applications) candidateJson(db, a)];
}

Object? offerApplication(FakeDatabase db, FakeRequest request) {
  final application = _ownApplication(db, request.params['id']);
  if (application['status'] != 'pending' &&
      application['status'] != 'pending_sync') {
    throw const ApiException(409, 'Cette candidature n’est plus en attente.');
  }
  final mission = db.missions[application['missionId']]!;
  final missionId = mission['id'] as String;
  final offered = _applicationsOf(
    db,
    missionId,
  ).where((a) => a['status'] == 'offered').length;
  final confirmed = _activeAssignmentsOf(db, missionId).length;
  if (offered + confirmed >= (mission['slotsTotal'] as int)) {
    throw const ApiException(409, 'Plus de place libre sur cette mission.');
  }
  application['status'] = 'offered';
  application['offerExpiresAt'] = request.now
      .toUtc()
      .add(offerValidity)
      .toIso8601String();
  return candidateJson(db, application);
}

Object? rejectApplication(FakeDatabase db, FakeRequest request) {
  final application = _ownApplication(db, request.params['id']);
  if (!const {
    'pending',
    'pending_sync',
    'offered',
  }.contains(application['status'])) {
    throw const ApiException(409, 'Cette candidature n’est plus en attente.');
  }
  application['status'] = 'rejected';
  return candidateJson(db, application);
}

Json _candidateOf(FakeDatabase db, Json assignment) =>
    candidateJson(db, db.applications[assignment['applicationId']]!);

Object? validateAssignment(FakeDatabase db, FakeRequest request) {
  final assignment = _ownAssignment(db, request.params['id']);
  if (assignment['status'] != 'submitted') {
    throw const ApiException(409, 'Rien à valider.');
  }
  payAssignment(db, assignment, request.now);
  return _candidateOf(db, assignment);
}

Object? contestAssignment(FakeDatabase db, FakeRequest request) {
  final assignment = _ownAssignment(db, request.params['id']);
  if (assignment['status'] != 'submitted') {
    throw const ApiException(409, 'Rien à valider.');
  }
  final reason = (request.body['reason'] as String? ?? '').trim();
  if (reason.isEmpty) {
    throw const ApiException(422, 'Indiquez le motif.');
  }
  assignment['status'] = 'contested';
  assignment['contestReason'] = reason;
  return _candidateOf(db, assignment);
}

Object? cancelMission(FakeDatabase db, FakeRequest request) {
  final mission = _ownMission(db, request.params['id']);
  final id = mission['id'] as String;
  final started = db.assignments.values.any(
    (a) =>
        a['missionId'] == id &&
        const {
          'in_progress',
          'submitted',
          'contested',
          'paid',
        }.contains(a['status']),
  );
  if (started) {
    throw const ApiException(
      409,
      'Impossible d’annuler : la mission a commencé.',
    );
  }
  mission['status'] = 'cancelled';
  for (final a in db.assignments.values.where(
    (a) => a['missionId'] == id && a['status'] == 'confirmed',
  )) {
    a['status'] = 'cancelled';
  }
  for (final a in _applicationsOf(db, id).where(
    (a) => const {'pending', 'pending_sync', 'offered'}.contains(a['status']),
  )) {
    a['status'] = 'rejected';
  }
  final wallet = db.wallets[db.currentUserId];
  if (wallet != null) _blocked(wallet).remove(id);
  return posterMissionJson(db, mission);
}

Object? getWallet(FakeDatabase db, FakeRequest request) {
  final wallet = _wallet(db);
  final payouts =
      db.payouts.values.where((p) => p['posterId'] == db.currentUserId).toList()
        ..sort(
          (a, b) => (b['validatedAt'] as String).compareTo(
            a['validatedAt'] as String,
          ),
        );
  return {
    'balance': wallet['balance'],
    'available': _available(wallet),
    'blocked': [
      for (final entry in _blocked(wallet).entries)
        if (entry.value > 0)
          {
            'missionId': entry.key,
            'title': db.missions[entry.key]?['title'] ?? '',
            'amount': entry.value,
          },
    ],
    'payouts': [
      for (final p in payouts)
        {
          'id': p['id'],
          'missionTitle': p['missionTitle'],
          'workerName': _workerName(db, p['workerId'] as String?),
          'amount': p['amount'],
          'paidAt': p['validatedAt'],
        },
    ],
  };
}

String _workerName(FakeDatabase db, String? workerId) {
  final worker = db.users[workerId];
  return worker == null ? '' : '${worker['firstName']} ${worker['lastName']}';
}
