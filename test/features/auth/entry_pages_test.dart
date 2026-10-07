import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';

import 'package:micro_opportunites/core/media/photo_picker.dart';

import '../../helpers/fake_photo_picker.dart';
import '../../helpers/pump_worker_app.dart';

void main() {
  testWidgets('A05 : e-mail vide → message, pas de navigation', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('Créer mon compte'));
    await tester.pumpAndSettle();
    expect(find.text('Saisissez votre e-mail.'), findsOneWidget);
  });

  testWidgets('A05 : connexion annonceur → Mes missions', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('J’ai déjà un compte'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email.field')),
      'annonceur@demo.bj',
    );
    await tester.enterText(find.byKey(const Key('password.field')), 'demo123');
    await tester.tap(find.text('Me connecter'));
    await tester.pumpAndSettle();
    expect(find.text('Mes missions'), findsWidgets);
  });

  testWidgets('A05 : bouton bloqué jusqu’à la fin de la reprise', (
    tester,
  ) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
      latency: const Duration(milliseconds: 400),
    );
    await tester.tap(find.text('J’ai déjà un compte'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email.field')),
      'executant@demo.bj',
    );
    await tester.enterText(find.byKey(const Key('password.field')), 'demo123');
    await tester.tap(find.text('Me connecter'));
    // Connexion répondue ; la lecture de la pièce d'identité est en cours.
    await tester.pump(const Duration(milliseconds: 500));
    final button = find.ancestor(
      of: find.text('Me connecter'),
      matching: find.byType(ElevatedButton),
    );
    expect(tester.widget<ElevatedButton>(button).onPressed, isNull);
    await tester.pumpAndSettle();
    expect(find.text('Missions près de toi'), findsOneWidget);
  });

  testWidgets('A05 : mauvais mot de passe', (tester) async {
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.email,
      session: null,
    );
    await tester.tap(find.text('J’ai déjà un compte'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email.field')),
      'annonceur@demo.bj',
    );
    await tester.enterText(find.byKey(const Key('password.field')), 'mauvais');
    await tester.tap(find.text('Me connecter'));
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou mot de passe incorrect.'), findsOneWidget);
  });

  testWidgets('A09 passeport : recto puis selfie, sans verso', (tester) async {
    await pumpWorkerApp(tester, initialLocation: EntryPaths.idDocument);
    await tester.tap(find.text('Passeport'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Photographier le recto'));
    await tester.pumpAndSettle();
    expect(find.text('Recto - Etape 1 sur 2'), findsOneWidget);
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pumpAndSettle();
    expect(find.text('Selfie - Etape 2 sur 2'), findsOneWidget);
    expect(find.text('Prenez un selfie'), findsOneWidget);
  });

  testWidgets('A09 : caméra frontale pour le selfie seulement', (tester) async {
    final picker = FakePhotoPicker();
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.idDocument,
      photoPicker: picker,
    );
    await tester.tap(find.text('Passeport'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Photographier le recto'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pumpAndSettle();
    expect(find.text('Selfie - Etape 2 sur 2'), findsOneWidget);
    // Selfie annulé : on vérifie la caméra demandée sans envoyer la pièce.
    picker.cancel = true;
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pumpAndSettle();
    expect(picker.frontCameras, [false, true]);
  });

  testWidgets('A09 : prise de vue annulée, on reste sur l’étape', (
    tester,
  ) async {
    final picker = FakePhotoPicker(cancel: true);
    await pumpWorkerApp(
      tester,
      initialLocation: EntryPaths.cameraFront,
      photoPicker: picker,
    );
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pumpAndSettle();
    expect(picker.sources, [PhotoSource.camera]);
    expect(find.text('Recto - Etape 1 sur 3'), findsOneWidget);
    picker.cancel = false;
    await tester.tap(find.byKey(const Key('camera.shutter')));
    await tester.pumpAndSettle();
    expect(find.text('Verso - Etape 2 sur 3'), findsOneWidget);
  });
}
