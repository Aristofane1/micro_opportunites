import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/geo/map_tiles.dart';
import 'package:micro_opportunites/core/media/photo_picker.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/core/time/clock.dart';

import '../support/fake_backend/fake_api_client.dart';
import '../support/fake_backend/seed.dart';
import '../support/fake_backend/simulated_location_service.dart';

import 'fake_photo_picker.dart';
import 'test_clock.dart';

/// Conteneur Riverpod de test : faux serveur sans latence, horloge figée,
/// pas de tuiles de carte, pas de nouvelle tentative automatique.
ProviderContainer createTestContainer({
  List<Override> overrides = const [],
  Duration latency = Duration.zero,
  DateTime Function()? clock,
  String initialLocation = WorkerPaths.explore,
  String? session = 'u1',
  ActiveRole role = ActiveRole.worker,
  LocationService locationService = const SimulatedLocationService(),
  PhotoPicker? photoPicker,
}) {
  final container = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(clock ?? () => fixedNow),
      apiClientProvider.overrideWith(
        (ref) => FakeApiClient(
          seedDatabase((clock ?? () => fixedNow)(), sessionUserId: session),
          clock: clock ?? () => fixedNow,
          latency: latency,
        ),
      ),
      locationServiceProvider.overrideWithValue(locationService),
      photoPickerProvider.overrideWithValue(photoPicker ?? FakePhotoPicker()),
      mapTilesEnabledProvider.overrideWithValue(false),
      initialLocationProvider.overrideWithValue(initialLocation),
      if (role != ActiveRole.worker)
        activeRoleProvider.overrideWith(() => _FixedRole(role)),
      ...overrides,
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}

/// Monte l'app complète (profil [role], Exécutant par défaut) et attend le premier affichage.
/// [beforePump] permet de préparer le faux serveur (ex. `nextError`).
Future<ProviderContainer> pumpWorkerApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  void Function(ProviderContainer container)? beforePump,
  Duration latency = Duration.zero,
  DateTime Function()? clock,
  String initialLocation = WorkerPaths.explore,
  String? session = 'u1',
  ActiveRole role = ActiveRole.worker,
  PhotoPicker? photoPicker,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final container = createTestContainer(
    latency: latency,
    clock: clock,
    initialLocation: initialLocation,
    session: session,
    role: role,
    photoPicker: photoPicker,
  );
  beforePump?.call(container);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const App()),
  );
  await tester.pumpAndSettle();
  return container;
}

/// Rôle actif imposé au démarrage, comme le raccourci de `main.dart`.
class _FixedRole extends ActiveRoleNotifier {
  _FixedRole(this._role);

  final ActiveRole _role;

  @override
  ActiveRole build() => _role;
}
