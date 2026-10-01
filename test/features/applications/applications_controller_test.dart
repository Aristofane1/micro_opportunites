import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/presentation/controllers/applications_controller.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  test('mes candidatures : 6 dont 4 en cours', () async {
    final container = createTestContainer();
    final all = await container.read(myApplicationsProvider.future);
    expect(all, hasLength(6));
    expect(all.where((a) => a.status.isCurrent), hasLength(4));
    final offer = all.firstWhere((a) => a.id == 'a1');
    expect(offer.status, ApplicationStatus.offered);
    expect(offer.mission.title, 'Réinstaller Windows sur un portable');
    expect(offer.mission.posterName, 'Koffi D.');
  });

  test('cible de candidature (résumé de la mission)', () async {
    final container = createTestContainer();
    final target = await container.read(applyTargetProvider('m1').future);
    expect(target.title, 'Distribution de flyers au carrefour');
    expect(target.posterName, 'Adjovi H.');
    expect(target.payAmount, 5000);
  });

  test(
    'Review focus : postuler deux fois ne crée qu’une candidature',
    () async {
      final container = createTestContainer();
      final actions = container.read(applicationActionsProvider.notifier);
      final first = await actions.apply(
        missionId: 'm1',
        message: 'Disponible.',
      );
      expect(
        (first as Success<Application>).value.status,
        ApplicationStatus.pending,
      );
      final second = await actions.apply(
        missionId: 'm1',
        message: 'Disponible.',
      );
      expect(
        (second as Err<Application>).failure,
        const ValidationFailure('Vous avez déjà postulé à cette mission.'),
      );
      final all = await container.read(myApplicationsProvider.future);
      expect(all.where((a) => a.missionId == 'm1'), hasLength(1));
    },
  );

  test('retirer : seulement une candidature en attente', () async {
    final container = createTestContainer();
    final actions = container.read(applicationActionsProvider.notifier);
    final withdrawn = await actions.withdraw('a3');
    expect(
      (withdrawn as Success<Application>).value.status,
      ApplicationStatus.withdrawn,
    );
    final refused = await actions.withdraw('a1');
    expect(refused, isA<Err<Application>>());
  });

  test(
    'confirmer l’offre donne une affectation ; la redécliner échoue',
    () async {
      final container = createTestContainer();
      final actions = container.read(applicationActionsProvider.notifier);
      final confirmed = await actions.confirmOffer('a1');
      final application = (confirmed as Success<Application>).value;
      expect(application.status, ApplicationStatus.confirmed);
      expect(application.assignmentId, isNotNull);
      final declined = await actions.declineOffer('a1');
      expect(
        (declined as Err<Application>).failure,
        const ValidationFailure('Cette offre n’est plus disponible.'),
      );
    },
  );
}
