import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';
import 'package:micro_opportunites/dev/fake_api/geo.dart';
import 'package:micro_opportunites/dev/fake_api/serializers.dart';

/// Rayon maximal du check-in (design : moins de 200 m de l'épingle).
const checkInRadiusMeters = 200;

Json _assignment(FakeDatabase db, String? id) {
  final assignment = db.assignments[id];
  if (assignment == null || assignment['workerId'] != db.currentUserId) {
    throw const ApiException(404, 'Mission introuvable.');
  }
  return assignment;
}

Object? getAssignment(FakeDatabase db, FakeRequest request) =>
    assignmentJson(db, _assignment(db, request.params['id']));

Object? checkIn(FakeDatabase db, FakeRequest request) {
  final assignment = _assignment(db, request.params['id']);
  if (assignment['status'] != 'confirmed') {
    throw const ApiException(409, 'Le check-in a déjà été fait.');
  }
  final meters =
      (distanceKm(
                asDouble(request.body['lat']),
                asDouble(request.body['lng']),
                asDouble(assignment['lat']),
                asDouble(assignment['lng']),
              ) *
              1000)
          .round();
  if (meters > checkInRadiusMeters) {
    throw ApiException(
      422,
      'Vous êtes à $meters m du lieu : rapprochez-vous à moins de $checkInRadiusMeters m.',
    );
  }
  assignment['status'] = 'in_progress';
  assignment['checkInAt'] = request.now.toUtc().toIso8601String();
  assignment['checkInDistanceM'] = meters;
  return assignmentJson(db, assignment);
}

Object? checkOut(FakeDatabase db, FakeRequest request) {
  final assignment = _assignment(db, request.params['id']);
  if (assignment['status'] != 'in_progress') {
    throw const ApiException(409, 'Faites d’abord votre check-in.');
  }
  final now = request.now.toUtc();
  assignment['status'] = 'submitted';
  assignment['checkOutAt'] = now.toIso8601String();
  assignment['note'] = request.body['note'];
  assignment['photos'] = (request.body['photos'] as List<dynamic>? ?? const [])
      .cast<String>();
  assignment['autoValidateAt'] = now
      .add(const Duration(hours: 48))
      .toIso8601String();
  return assignmentJson(db, assignment);
}

Object? withdrawFromAssignment(FakeDatabase db, FakeRequest request) {
  final assignment = _assignment(db, request.params['id']);
  if (assignment['status'] != 'confirmed') {
    throw const ApiException(
      409,
      'Impossible de se désister après le check-in.',
    );
  }
  assignment['status'] = 'cancelled';
  final application = db.applications[assignment['applicationId']];
  if (application != null) application['status'] = 'withdrawn';
  final mission = db.missions[assignment['missionId']];
  if (mission != null) mission['slotsFree'] = (mission['slotsFree'] as int) + 1;
  return assignmentJson(db, assignment);
}
