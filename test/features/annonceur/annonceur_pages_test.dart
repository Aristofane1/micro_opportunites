import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
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
}
