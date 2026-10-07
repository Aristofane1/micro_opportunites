import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/features/assignments/data/assignments_providers.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/presentation/controllers/assignments_controller.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

void main() {
  test('mission confirmée : adresse exacte et trajet', () async {
    final container = createTestContainer();
    final assignment = await container.read(assignmentProvider('as1').future);
    expect(assignment.status, AssignmentStatus.confirmed);
    expect(assignment.address, 'Godomey, rue de la pharmacie');
    expect(assignment.distanceKm, greaterThan(0));
    expect(assignment.travelMinutes, greaterThanOrEqualTo(1));
  });

  test('check-in à la position simulée (~40 m) puis check-out', () async {
    final container = createTestContainer();
    final actions = container.read(assignmentActionsProvider.notifier);
    final confirmed = await container.read(assignmentProvider('as1').future);
    final checkedIn = await actions.checkIn(confirmed);
    final inProgress = (checkedIn as Success<Assignment>).value;
    expect(inProgress.status, AssignmentStatus.inProgress);
    expect(inProgress.checkInDistanceMeters, 40);
    final checkedOut = await actions.checkOut(
      'as1',
      note: 'Fait',
      photos: const [],
    );
    final submitted = (checkedOut as Success<Assignment>).value;
    expect(submitted.status, AssignmentStatus.submitted);
    expect(submitted.autoValidateAt, fixedNow.add(const Duration(hours: 48)));
  });

  test('check-in trop loin refusé avec un message clair', () async {
    final container = createTestContainer();
    final result = await container
        .read(assignmentsRepositoryProvider)
        .checkIn('as1', latitude: 6.5, longitude: 2.4);
    final failure = (result as Err<Assignment>).failure;
    expect(failure, isA<ValidationFailure>());
    expect(failure.message, contains('rapprochez-vous'));
  });

  test('se désister d’une mission confirmée', () async {
    final container = createTestContainer();
    final result = await container
        .read(assignmentActionsProvider.notifier)
        .withdraw('as1');
    expect(
      (result as Success<Assignment>).value.status,
      AssignmentStatus.cancelled,
    );
  });

  group('check-in : échec de localisation', () {
    Future<void> expectCheckInErr(Object thrown, Failure expected) async {
      final container = createTestContainer(
        locationService: _ThrowingLocation(thrown),
      );
      final confirmed = await container.read(assignmentProvider('as1').future);
      final result = await container
          .read(assignmentActionsProvider.notifier)
          .checkIn(confirmed);
      final failure = (result as Err<Assignment>).failure;
      expect(failure, isA<ValidationFailure>());
      expect(failure.message, expected.message);
      final after = await container.read(assignmentProvider('as1').future);
      expect(after.status, AssignmentStatus.confirmed);
    }

    test('une Failure est renvoyée telle quelle', () {
      return expectCheckInErr(
        const ValidationFailure('Localisation refusée.'),
        const ValidationFailure('Localisation refusée.'),
      );
    });

    test('un délai dépassé devient un message clair', () {
      return expectCheckInErr(
        TimeoutException('gps'),
        const ValidationFailure(
          'Activez la localisation pour faire le check-in.',
        ),
      );
    });
  });
}

class _ThrowingLocation implements LocationService {
  _ThrowingLocation(this._thrown);

  final Object _thrown;

  @override
  Future<GeoPoint> currentPosition({GeoPoint? expected}) async => throw _thrown;
}
