import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/bootstrap.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

import 'test_clock.dart';

/// Conteneur Riverpod de test : faux serveur sans latence, horloge figée,
/// pas de tuiles de carte, pas de nouvelle tentative automatique.
ProviderContainer createTestContainer({
  List<Override> overrides = const [],
  Duration latency = Duration.zero,
  DateTime Function()? clock,
  String initialLocation = WorkerPaths.explore,
  String? session = 'u1',
}) {
  final container = ProviderContainer(
    overrides: [
      ...appOverrides(
        latency: latency,
        clock: clock ?? () => fixedNow,
        mapTiles: false,
        session: session,
      ),
      initialLocationProvider.overrideWithValue(initialLocation),
      ...overrides,
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}

/// Monte l'app complète (profil Exécutant) et attend le premier affichage.
/// [beforePump] permet de préparer le faux serveur (ex. `nextError`).
Future<ProviderContainer> pumpWorkerApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  void Function(ProviderContainer container)? beforePump,
  Duration latency = Duration.zero,
  DateTime Function()? clock,
  String initialLocation = WorkerPaths.explore,
  String? session = 'u1',
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final container = createTestContainer(
    latency: latency,
    clock: clock,
    initialLocation: initialLocation,
    session: session,
  );
  beforePump?.call(container);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const App()),
  );
  await tester.pumpAndSettle();
  return container;
}
