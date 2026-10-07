import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';
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

  test('un candidat sans profil ne casse pas la liste des candidats', () async {
    final container = createTestContainer(session: null);
    final api = container.read(apiClientProvider);
    await api.post(
      '/auth/signup',
      body: {'email': 'nouveau@demo.bj', 'password': 'secret1'},
    );
    await api.post('/me/role', body: {'role': 'worker'});
    // Postuler exige une pièce d’identité envoyée.
    await api.post(
      '/auth/kyc',
      body: {
        'documentType': 'passport',
        'countryCode': 'BJ',
        'frontPath': '/tmp/front.jpg',
        'selfiePath': '/tmp/selfie.jpg',
      },
    );
    await api.post(
      '/missions/m20/applications',
      body: {'message': 'Je débute, très motivé.'},
    );
    await api.post(
      '/auth/login',
      body: {'email': 'annonceur@demo.bj', 'password': 'demo123'},
    );

    final candidates = await container.read(
      missionCandidatesProvider('m20').future,
    );
    expect(candidates, hasLength(3));
    final fresh = candidates.last;
    expect(fresh.memberSince, fixedNow);
    expect(fresh.pitch, 'Je débute, très motivé.');
    expect(fresh.isNew, isTrue);
    expect(fresh.isExpert, isFalse);
    expect(fresh.review, isNull);
  });

  test('C10 : expert, missions réalisées et dernier avis', () async {
    final container = createTestContainer(session: 'u10');
    final candidates = await container.read(
      missionCandidatesProvider('m20').future,
    );
    final senami = candidates.firstWhere((c) => c.name == 'Sènami O.');
    expect(senami.isExpert, isTrue);
    expect(senami.doneMissions.map((d) => (d.category, d.count)), [
      (MissionCategory.dataEntry, 12),
      (MissionCategory.event, 9),
    ]);
    expect(senami.review?.author, 'Cabinet Hounkpè');
  });

  test('montant à bloquer à l’heure : arrondi par place, × places', () {
    const draft = MissionDraft(
      payAmount: 1001,
      payUnit: PayUnit.hourly,
      durationMinutes: 90,
      slotsTotal: 3,
    );
    // Serveur : (1001 × 90 / 60).round() = 1502 par place.
    expect(draft.totalToBlock, 1502 * 3);
  });

  group('date limite par défaut du brouillon', () {
    // Horloge locale : mardi 29 sept. 2026, 9 h.
    final now = DateTime(2026, 9, 29, 9);

    MissionDraftController controller() => createTestContainer(
      session: 'u10',
      clock: () => now,
    ).read(missionDraftControllerProvider.notifier);

    test('la veille à 18 h', () {
      final draft = controller()..updateDate(DateTime(2026, 10, 1));
      expect(draft.state.startAt, DateTime(2026, 10, 1, 8));
      expect(draft.state.applyDeadline, DateTime(2026, 9, 30, 18));
    });

    test('mission du jour : 1 h avant le début', () {
      final draft = controller()
        ..updateDate(DateTime(2026, 9, 29))
        ..updateTime(15, 0);
      expect(draft.state.applyDeadline, DateTime(2026, 9, 29, 14));
    });

    test('jamais dans le passé : à choisir', () {
      final draft = controller()
        ..updateDate(DateTime(2026, 9, 29))
        ..updateTime(9, 30);
      expect(draft.state.applyDeadline, isNull);
    });

    test('recalculée quand la date change, sauf si elle a été choisie', () {
      final draft = controller()
        ..updateDate(DateTime(2026, 9, 29))
        ..updateTime(15, 0)
        ..updateDate(DateTime(2026, 10, 2));
      expect(draft.state.applyDeadline, DateTime(2026, 10, 1, 18));
      draft
        ..updateApplyDeadline(DateTime(2026, 9, 30, 12))
        ..updateDate(DateTime(2026, 10, 5));
      expect(draft.state.applyDeadline, DateTime(2026, 9, 30, 12));
    });

    test('heure sans date : lendemain selon l’horloge injectée', () {
      final draft = controller()..updateTime(10, 0);
      expect(draft.state.startAt, DateTime(2026, 9, 30, 10));
      expect(draft.state.applyDeadline, DateTime(2026, 9, 29, 18));
    });
  });
}
