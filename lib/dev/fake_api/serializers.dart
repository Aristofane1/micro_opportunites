import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/geo.dart';

/// Mission telle que vue par un candidat : jamais d'adresse ni de zone.
Json publicMission(FakeDatabase db, Json mission) {
  final poster = db.posters[mission['posterId']]!;
  final alreadyApplied = db.applications.values.any(
    (a) =>
        a['missionId'] == mission['id'] &&
        a['workerId'] == db.currentUserId &&
        a['status'] != 'withdrawn',
  );
  return {
    'id': mission['id'],
    'title': mission['title'],
    'category': mission['category'],
    'city': mission['city'],
    'startAt': mission['startAt'],
    'durationMin': mission['durationMin'],
    'pay': mission['pay'],
    'slotsTotal': mission['slotsTotal'],
    'slotsFree': mission['slotsFree'],
    'description': mission['description'],
    'applyDeadline': mission['applyDeadline'],
    'publishedAt': mission['publishedAt'],
    'status': mission['status'],
    'poster': {
      'id': poster['id'],
      'displayName': poster['displayName'],
      'initials': poster['initials'],
      'verified': poster['verified'],
      'rating': poster['rating'],
      'avgValidationHours': poster['avgValidationHours'],
    },
    'publicQuestionsCount': mission['publicQuestionsCount'],
    'alreadyApplied': alreadyApplied,
  };
}

Json applicationJson(FakeDatabase db, Json application) {
  final mission = db.missions[application['missionId']]!;
  final poster = db.posters[mission['posterId']]!;
  return {
    'id': application['id'],
    'missionId': application['missionId'],
    'status': application['status'],
    'message': application['message'],
    'createdAt': application['createdAt'],
    'offerExpiresAt': application['offerExpiresAt'],
    'assignmentId': application['assignmentId'],
    'mission': {
      'title': mission['title'],
      'city': mission['city'],
      'startAt': mission['startAt'],
      'durationMin': mission['durationMin'],
      'payAmount': (mission['pay'] as Json)['amount'],
      'posterName': poster['displayName'],
      'posterRating': poster['rating'],
      'posterVerified': poster['verified'],
    },
  };
}

/// Affectation vue par l'exécutant retenu : adresse exacte incluse,
/// distance et temps de trajet calculés depuis sa position.
Json assignmentJson(FakeDatabase db, Json assignment) {
  final user = db.currentUser;
  final km = distanceKm(
    asDouble(user['lat']),
    asDouble(user['lng']),
    asDouble(assignment['lat']),
    asDouble(assignment['lng']),
  );
  return {
    ...assignment,
    'contestReason': assignment['contestReason'],
    'distanceKm': double.parse(km.toStringAsFixed(1)),
    'travelMinutes': (km / 15 * 60).ceil().clamp(1, 600),
  };
}
