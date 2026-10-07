import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/missions/data/datasources/missions_remote_data_source.dart';
import 'package:micro_opportunites/features/missions/data/missions_providers.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';

import '../../helpers/pump_worker_app.dart';

/// Position fixe (Ouidah), refus de permission, ou réponse qui n'arrive jamais.
class _Location implements LocationService {
  const _Location(this.answer);

  final Future<GeoPoint> Function() answer;

  @override
  Future<GeoPoint> currentPosition({GeoPoint? expected}) => answer();
}

const _ouidah = (latitude: 6.3667, longitude: 2.085);

/// Enregistre les requêtes ; répond une page vide.
class _RecordingApi implements ApiClient {
  final queries = <Map<String, String>?>[];

  @override
  Future<Object?> get(String path, {Map<String, String>? query}) async {
    queries.add(query);
    return {
      'items': <Object?>[],
      'total': 0,
      'radiusKm': 5,
      'updatedAt': '2026-09-29T08:00:00.000Z',
    };
  }

  @override
  Future<Object?> post(String path, {Object? body}) =>
      throw UnimplementedError();

  @override
  Future<Object?> delete(String path) => throw UnimplementedError();
}

void main() {
  test('Explorer : rayon autour de la position de l’appareil', () async {
    final container = createTestContainer(
      locationService: _Location(() async => _ouidah),
    );
    final page = await container.read(exploreMissionsProvider.future);
    expect(page.items.map((m) => m.id), contains('m10'));
  });

  test('permission refusée : retour silencieux au profil', () async {
    final container = createTestContainer(
      locationService: _Location(
        () async => throw const ValidationFailure('Activez la localisation.'),
      ),
    );
    final page = await container.read(exploreMissionsProvider.future);
    expect(page.total, 7);
    expect(page.items.map((m) => m.id), isNot(contains('m10')));
  });

  testWidgets('position lente : repli sur le profil après le délai court', (
    tester,
  ) async {
    final never = Completer<GeoPoint>();
    final container = createTestContainer(
      locationService: _Location(() => never.future),
    );
    var done = false;
    final page = container
        .read(exploreMissionsProvider.future)
        .whenComplete(() => done = true);
    await tester.pump(exploreLocationTimeout - const Duration(seconds: 1));
    expect(done, isFalse, reason: 'attend encore la position');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(done, isTrue, reason: 'pas d’attente au-delà de 4 s');
    final result = await page;
    expect(result.total, 7);
    expect(result.items.map((m) => m.id), isNot(contains('m10')));
  });

  test('délai d’Explorer plus court que celui du GPS', () {
    expect(exploreLocationTimeout, const Duration(seconds: 4));
    expect(exploreLocationTimeout < locationTimeout, isTrue);
  });

  group('source de données', () {
    test('position transmise en lat/lng', () async {
      final api = _RecordingApi();
      await MissionsRemoteDataSource(
        api,
        devicePosition: () async => _ouidah,
      ).fetchMissions(const MissionFilters());
      expect(api.queries.single!['lat'], '6.3667');
      expect(api.queries.single!['lng'], '2.085');
    });

    test('ville choisie : pas de position', () async {
      final api = _RecordingApi();
      var asked = false;
      await MissionsRemoteDataSource(
        api,
        devicePosition: () async {
          asked = true;
          return _ouidah;
        },
      ).fetchMissions(const MissionFilters(city: 'Cotonou'));
      expect(api.queries.single!.containsKey('lat'), isFalse);
      expect(asked, isFalse);
    });

    test('sans position : rien n’est envoyé', () async {
      final api = _RecordingApi();
      await MissionsRemoteDataSource(
        api,
        devicePosition: () async => null,
      ).fetchMissions(const MissionFilters());
      expect(api.queries.single!.containsKey('lat'), isFalse);
      expect(api.queries.single!.containsKey('lng'), isFalse);
    });
  });

  group('tryCurrentPosition', () {
    test('position obtenue', () async {
      expect(await tryCurrentPosition(_Location(() async => _ouidah)), _ouidah);
    });

    test('erreur : null', () async {
      expect(
        await tryCurrentPosition(
          _Location(() async => throw const ValidationFailure('refus')),
        ),
        isNull,
      );
    });

    test('délai dépassé : null', () async {
      final never = Completer<GeoPoint>();
      expect(
        await tryCurrentPosition(
          _Location(() => never.future),
          timeout: const Duration(milliseconds: 10),
        ),
        isNull,
      );
    });

    test('délai par défaut : celui du GPS', () {
      expect(locationTimeout, const Duration(seconds: 15));
    });
  });
}
