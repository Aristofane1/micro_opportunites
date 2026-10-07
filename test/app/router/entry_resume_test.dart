import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/app/router/entry_resume.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../support/fake_backend/fake_api_client.dart';
import '../../support/fake_backend/fake_database.dart';
import '../../helpers/pump_worker_app.dart';

/// Une branche de la règle de reprise : état du compte et écran attendu.
typedef _Case = ({
  String name,
  String userId,
  String email,
  void Function(Json user) prepare,
  String path,
});

final _cases = <_Case>[
  (
    name: 'prénom vide → A07',
    userId: 'u1',
    email: 'executant@demo.bj',
    prepare: (user) => user['firstName'] = '',
    path: EntryPaths.profile,
  ),
  (
    name: 'exécutant sans pièce d’identité → A08',
    userId: 'u1',
    email: 'executant@demo.bj',
    prepare: (user) => user.remove('kyc'),
    path: EntryPaths.idDocument,
  ),
  (
    name: 'sans rôle ni pièce d’identité → A08',
    userId: 'u1',
    email: 'executant@demo.bj',
    prepare: (user) => user
      ..remove('kyc')
      ..['role'] = null,
    path: EntryPaths.idDocument,
  ),
  (
    name: 'sans rôle, pièce envoyée → A13',
    userId: 'u1',
    email: 'executant@demo.bj',
    prepare: (user) => user['role'] = null,
    path: EntryPaths.usage,
  ),
  (
    name: 'exécutant vérifié → Explorer',
    userId: 'u1',
    email: 'executant@demo.bj',
    prepare: (_) {},
    path: WorkerPaths.explore,
  ),
  (
    name: 'annonceur sans pièce d’identité → Mes missions',
    userId: 'u10',
    email: 'annonceur@demo.bj',
    prepare: (user) => user.remove('kyc'),
    path: PosterPaths.missions,
  ),
];

String _path(ProviderContainer container) => container
    .read(appRouterProvider)
    .routerDelegate
    .currentConfiguration
    .uri
    .path;

void _prepare(ProviderContainer container, _Case c) => c.prepare(
  (container.read(apiClientProvider) as FakeApiClient).db.users[c.userId]!,
);

void main() {
  group('resumePath', () {
    test('règle unique', () {
      expect(
        resumePath(firstName: ' ', role: 'worker', kyc: KycStatus.verified),
        EntryPaths.profile,
      );
      expect(
        resumePath(firstName: 'Awa', role: 'worker', kyc: KycStatus.none),
        EntryPaths.idDocument,
      );
      expect(
        resumePath(firstName: 'Awa', role: null, kyc: KycStatus.none),
        EntryPaths.idDocument,
      );
      expect(
        resumePath(firstName: 'Awa', role: null, kyc: KycStatus.rejected),
        EntryPaths.usage,
      );
      expect(
        resumePath(firstName: 'Awa', role: 'poster', kyc: KycStatus.none),
        PosterPaths.missions,
      );
      expect(
        resumePath(firstName: 'Awa', role: 'worker', kyc: KycStatus.pending),
        WorkerPaths.explore,
      );
    });
  });

  group('splash', () {
    for (final c in _cases) {
      testWidgets(c.name, (tester) async {
        final container = await pumpWorkerApp(
          tester,
          initialLocation: EntryPaths.splash,
          session: c.userId,
          beforePump: (container) => _prepare(container, c),
        );
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
        expect(_path(container), c.path);
        if (c.path == PosterPaths.missions) {
          expect(container.read(activeRoleProvider), ActiveRole.poster);
        }
      });
    }
  });

  group('connexion', () {
    for (final c in _cases) {
      testWidgets(c.name, (tester) async {
        final container = await pumpWorkerApp(
          tester,
          initialLocation: EntryPaths.email,
          session: null,
          beforePump: (container) => _prepare(container, c),
        );
        await tester.tap(find.text('J’ai déjà un compte'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(const Key('email.field')), c.email);
        await tester.enterText(
          find.byKey(const Key('password.field')),
          'demo123',
        );
        await tester.tap(find.text('Me connecter'));
        await tester.pumpAndSettle();
        expect(_path(container), c.path);
        if (c.path == PosterPaths.missions) {
          expect(container.read(activeRoleProvider), ActiveRole.poster);
        }
      });
    }
  });
}
