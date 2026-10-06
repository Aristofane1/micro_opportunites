import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_controllers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

void main() {
  test('mes missions de démo', () async {
    final container = createTestContainer(session: 'u10');
    final missions = await container.read(myMissionsProvider.future);
    expect(missions.map((m) => m.id), containsAll(['m20', 'm21']));
    expect(
      missions.firstWhere((m) => m.id == 'm21').status,
      MissionStatus.inProgress,
    );
  });

  test(
    'publier : brouillon envoyé, argent bloqué, brouillon réinitialisé',
    () async {
      final container = createTestContainer(session: 'u10');
      final draft = container.read(missionDraftControllerProvider.notifier)
        ..updateTitle('Aide déménagement')
        ..updateCategory(MissionCategory.other)
        ..updateDescription('Porter des cartons.')
        ..updateCity('Abomey-Calavi')
        ..updateAddress('Rue 12, Tankpè')
        ..updateLandmark('Portail vert')
        ..updatePin(6.449, 2.356)
        ..updateDate(fixedNow.add(const Duration(days: 2)))
        ..updatePayAmount(5000);
      expect(draft, isNotNull);
      final before = (await container.read(walletProvider.future)).available;
      final result = await container
          .read(annonceurActionsProvider.notifier)
          .publish();
      expect((result as Success).value.status, MissionStatus.published);
      expect(
        (await container.read(walletProvider.future)).available,
        before - 5000,
      );
      expect(container.read(missionDraftControllerProvider).title, isNull);
    },
  );

  test('solde insuffisant', () async {
    final container = createTestContainer(session: 'u10');
    container.read(missionDraftControllerProvider.notifier)
      ..updateTitle('Trop cher')
      ..updateCategory(MissionCategory.other)
      ..updateCity('Abomey-Calavi')
      ..updateAddress('Rue 1')
      ..updatePin(6.449, 2.356)
      ..updateDate(fixedNow.add(const Duration(days: 2)))
      ..updatePayAmount(300000);
    final result = await container
        .read(annonceurActionsProvider.notifier)
        .publish();
    expect(
      (result as Err).failure,
      ValidationFailure(
        'Solde insuffisant pour bloquer ${formatFcfa(300000)}.',
      ),
    );
  });

  test('retenir un candidat puis valider la mission terminée', () async {
    final container = createTestContainer(session: 'u10');
    final candidates = await container.read(
      missionCandidatesProvider('m20').future,
    );
    final retained = await container
        .read(annonceurActionsProvider.notifier)
        .retain(candidates.first.id);
    expect(
      (retained as Success<Candidate>).value.status,
      CandidateStatus.retained,
    );
    final done = (await container.read(
      missionCandidatesProvider('m21').future,
    )).single;
    final validated = await container
        .read(annonceurActionsProvider.notifier)
        .validate(done.assignmentId!);
    expect(
      (validated as Success<Candidate>).value.attendance,
      AttendanceStatus.validated,
    );
  });
}
