import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/dev/fake_api/fake_api_client.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

Future<void> _pumpPoster(
  WidgetTester tester, {
  String initialLocation = PosterPaths.missions,
  void Function(ProviderContainer container)? beforePump,
}) => pumpWorkerApp(
  tester,
  session: 'u10',
  role: ActiveRole.poster,
  initialLocation: initialLocation,
  beforePump: beforePump,
);

void main() {
  testWidgets('C01 : mes missions et bandeau de validation', (tester) async {
    await _pumpPoster(tester);
    expect(find.text('Accueil au salon de l’artisanat'), findsOneWidget);
    expect(find.text('Tri de vêtements pour une vente'), findsOneWidget);
    expect(find.text('Travail à valider'), findsOneWidget);
    expect(find.text('En cours (2)'), findsOneWidget);
    expect(find.text('Terminées'), findsOneWidget);
  });

  testWidgets('C10 : profil avec expert, missions réalisées et avis', (
    tester,
  ) async {
    await _pumpPoster(tester);
    await tester.tap(find.text('Accueil au salon de l’artisanat'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Candidats'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sènami O.'));
    await tester.pumpAndSettle();
    expect(find.text('Expert'), findsOneWidget);
    expect(find.text('Événement × 9 · confirmée'), findsOneWidget);
    expect(find.text('Saisie de données × 12'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Cabinet Hounkpè'), 200);
    expect(find.text('Cabinet Hounkpè'), findsOneWidget);
  });

  testWidgets('Publier : 3 étapes puis C07 « Montant bloqué »', (tester) async {
    await _pumpPoster(
      tester,
      beforePump: (container) {
        container.read(missionDraftControllerProvider.notifier)
          ..updateTitle('Aide déménagement')
          ..updateCategory(MissionCategory.other)
          ..updateDescription('Porter des cartons.')
          ..updateCity('Abomey-Calavi')
          ..updateAddress('Rue 12, Tankpè')
          ..updateDate(fixedNow.add(const Duration(days: 2)))
          ..updatePayAmount(5000);
      },
    );
    await tester.tap(find.text('Publier'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouvelle mission'));
    await tester.pumpAndSettle();

    expect(
      find.text('Quoi · Où · Quand et combien', findRichText: true),
      findsOneWidget,
    );
    expect(find.textContaining('Payer', findRichText: true), findsNothing);
    await tester.tap(find.text('Suivant : où'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Suivant : quand et combien'));
    await tester.pumpAndSettle();
    expect(
      find.text('${formatFcfa(5000)} seront bloqués sur votre solde.'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Publier'));
    await tester.pumpAndSettle();

    expect(find.text('Votre mission est en ligne'), findsOneWidget);
    expect(find.text('Montant bloqué'), findsOneWidget);
  });

  testWidgets('C09 : retenir un candidat', (tester) async {
    await _pumpPoster(tester);
    await tester.tap(find.text('Accueil au salon de l’artisanat'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Candidats'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Retenir').first);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('est retenu(e) : 12 h pour confirmer.'),
      findsOneWidget,
    );
  });

  testWidgets('C13 : contester exige un motif puis suspend le versement', (
    tester,
  ) async {
    final container = await pumpWorkerApp(
      tester,
      session: 'u10',
      role: ActiveRole.poster,
      initialLocation: PosterPaths.contest('m21', 'm21'),
    );
    await tester.tap(find.widgetWithText(AppButton, 'Contester'));
    await tester.pumpAndSettle();
    expect(find.text('Indiquez le motif.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Travail incomplet');
    await tester.tap(find.widgetWithText(AppButton, 'Contester'));
    await tester.pumpAndSettle();
    expect(
      (container.read(apiClientProvider) as FakeApiClient)
          .db
          .assignments['m21']!['status'],
      'contested',
    );
  });

  testWidgets('C14 : annuler une mission débloque l’argent', (tester) async {
    await pumpWorkerApp(
      tester,
      session: 'u10',
      role: ActiveRole.poster,
      initialLocation: PosterPaths.cancel('m20'),
    );
    expect(find.text(formatFcfa(12000)), findsWidgets);
    await tester.tap(find.widgetWithText(AppButton, 'Annuler la mission'));
    await tester.pumpAndSettle();
    // La mission annulée est dans l'onglet « Terminées ».
    await tester.tap(find.text('Terminées'));
    await tester.pumpAndSettle();
    expect(find.text('Annulée'), findsWidgets);
  });

  testWidgets('C14 : refus si la mission a commencé', (tester) async {
    await pumpWorkerApp(
      tester,
      session: 'u10',
      role: ActiveRole.poster,
      initialLocation: PosterPaths.cancel('m21'),
    );
    await tester.tap(find.widgetWithText(AppButton, 'Annuler la mission'));
    await tester.pumpAndSettle();
    expect(
      find.text('Impossible d’annuler : la mission a commencé.'),
      findsOneWidget,
    );
  });

  testWidgets('C15 : solde, disponible et montants bloqués', (tester) async {
    await pumpWorkerApp(
      tester,
      session: 'u10',
      role: ActiveRole.poster,
      initialLocation: PosterPaths.payments,
    );
    expect(find.text(formatFcfa(200000)), findsOneWidget);
    expect(find.text(formatFcfa(180000)), findsOneWidget);
    expect(find.text('Accueil au salon de l’artisanat'), findsOneWidget);
  });

  Future<void> manage(WidgetTester tester, String id, {String? status}) =>
      pumpWorkerApp(
        tester,
        session: 'u10',
        role: ActiveRole.poster,
        initialLocation: PosterPaths.missionManage(id),
        beforePump: status == null
            ? null
            : (container) =>
                  (container.read(apiClientProvider) as FakeApiClient)
                          .db
                          .missions[id]!['status'] =
                      status,
      );

  testWidgets('C05 : « Annuler la mission » sur une mission publiée', (
    tester,
  ) async {
    await manage(tester, 'm20');
    expect(find.text('Annuler la mission'), findsOneWidget);
  });

  testWidgets('C05 : pas d’annulation une fois la mission commencée', (
    tester,
  ) async {
    await manage(tester, 'm21');
    expect(find.text('Tri de vêtements pour une vente'), findsOneWidget);
    expect(find.text('Annuler la mission'), findsNothing);
  });

  testWidgets('C05 : pas d’annulation d’une mission déjà annulée', (
    tester,
  ) async {
    await manage(tester, 'm20', status: 'cancelled');
    expect(find.text('Accueil au salon de l’artisanat'), findsOneWidget);
    expect(find.text('Annuler la mission'), findsNothing);
  });
}
