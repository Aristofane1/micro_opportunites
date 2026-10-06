import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';
import 'package:micro_opportunites/dev/fake_api/serializers.dart';

Json _application(FakeDatabase db, String? id) {
  final application = db.applications[id];
  if (application == null || application['workerId'] != db.currentUserId) {
    throw const ApiException(404, 'Candidature introuvable.');
  }
  return application;
}

Object? listMyApplications(FakeDatabase db, FakeRequest request) {
  final mine =
      db.applications.values
          .where((a) => a['workerId'] == db.currentUserId)
          .toList()
        ..sort(
          (a, b) =>
              (b['createdAt'] as String).compareTo(a['createdAt'] as String),
        );
  return [for (final a in mine) applicationJson(db, a)];
}

Object? applyToMission(FakeDatabase db, FakeRequest request) {
  final missionId = request.params['id']!;
  final mission = db.missions[missionId];
  if (mission == null || mission['status'] != 'published') {
    throw const ApiException(404, 'Cette mission n’est plus disponible.');
  }
  if (mission['posterId'] == db.currentUserId) {
    throw const ApiException(
      422,
      'Vous ne pouvez pas postuler à votre propre mission.',
    );
  }
  if ((mission['slotsFree'] as int) <= 0) {
    throw const ApiException(409, 'Cette mission est complète.');
  }
  final alreadyApplied = db.applications.values.any(
    (a) =>
        a['missionId'] == missionId &&
        a['workerId'] == db.currentUserId &&
        a['status'] != 'withdrawn',
  );
  if (alreadyApplied) {
    throw const ApiException(409, 'Vous avez déjà postulé à cette mission.');
  }
  final message = (request.body['message'] as String?)?.trim() ?? '';
  if (message.length > 300) {
    throw const ApiException(422, 'Votre message dépasse 300 caractères.');
  }
  final id = db.newId('a');
  db.applications[id] = {
    'id': id,
    'missionId': missionId,
    'workerId': db.currentUserId,
    'status': 'pending',
    'message': message,
    'createdAt': request.now.toUtc().toIso8601String(),
    'offerExpiresAt': null,
    'assignmentId': null,
  };
  return applicationJson(db, db.applications[id]!);
}

Object? withdrawApplication(FakeDatabase db, FakeRequest request) {
  final application = _application(db, request.params['id']);
  if (application['status'] != 'pending' &&
      application['status'] != 'pending_sync') {
    throw const ApiException(
      409,
      'Cette candidature ne peut plus être retirée.',
    );
  }
  application['status'] = 'withdrawn';
  return applicationJson(db, application);
}

Object? confirmOffer(FakeDatabase db, FakeRequest request) {
  final application = _application(db, request.params['id']);
  if (application['status'] != 'offered') {
    throw const ApiException(409, 'Cette offre n’est plus disponible.');
  }
  final mission = db.missions[application['missionId']]!;
  final private = mission['private'] as Json;
  final poster = db.posters[mission['posterId']]!;
  final assignmentId = db.newId('as');
  db.assignments[assignmentId] = {
    'id': assignmentId,
    'missionId': mission['id'],
    'applicationId': application['id'],
    'workerId': db.currentUserId,
    'title': mission['title'],
    'status': 'confirmed',
    'startAt': mission['startAt'],
    'durationMin': mission['durationMin'],
    'payAmount': mission['slotAmount'],
    'city': mission['city'],
    'district': private['district'],
    'address': private['address'],
    'landmark': private['landmark'],
    'lat': private['lat'],
    'lng': private['lng'],
    'briefing': private['briefing'],
    'posterName': poster['displayName'],
    'payoutOperator': 'MTN MoMo',
    'checkInAt': null,
    'checkInDistanceM': null,
    'checkOutAt': null,
    'note': null,
    'photos': <String>[],
    'autoValidateAt': null,
  };
  application['status'] = 'confirmed';
  application['assignmentId'] = assignmentId;
  mission['slotsFree'] = ((mission['slotsFree'] as int) - 1).clamp(0, 999);
  // Mission complète : les autres candidatures en attente sont closes.
  if ((mission['slotsFree'] as int) <= 0) {
    for (final other in db.applications.values.where(
      (a) =>
          a['missionId'] == mission['id'] &&
          const {'pending', 'pending_sync'}.contains(a['status']),
    )) {
      other['status'] = 'rejected';
    }
  }
  return applicationJson(db, application);
}

Object? declineOffer(FakeDatabase db, FakeRequest request) {
  final application = _application(db, request.params['id']);
  if (application['status'] != 'offered') {
    throw const ApiException(409, 'Cette offre n’est plus disponible.');
  }
  application['status'] = 'declined';
  return applicationJson(db, application);
}
