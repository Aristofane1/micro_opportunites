import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/account/presentation/controllers/current_user_controller.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';

import '../../helpers/pump_worker_app.dart';
import '../../helpers/test_clock.dart';

void main() {
  test('connexion correcte : compte annonceur avec son rôle', () async {
    final container = createTestContainer(session: null);
    final result = await container
        .read(authActionsProvider.notifier)
        .login('annonceur@demo.bj', 'demo123');
    final account = (result as Success<Account>).value;
    expect(account.role, 'poster');
    expect(account.email, 'annonceur@demo.bj');
  });

  test('mauvais mot de passe refusé', () async {
    final container = createTestContainer(session: null);
    final result = await container
        .read(authActionsProvider.notifier)
        .login('annonceur@demo.bj', 'mauvais');
    expect(
      (result as Err).failure,
      const ValidationFailure('E-mail ou mot de passe incorrect.'),
    );
  });

  test('inscription puis profil : le prénom est celui du profil', () async {
    final container = createTestContainer(session: null);
    final actions = container.read(authActionsProvider.notifier);
    final signed = await actions.signup('awa@demo.bj', 'secret1');
    expect((signed as Success<Account>).value.role, isNull);
    await actions.saveProfile(
      firstName: 'Awa',
      lastName: 'Dossou',
      birthDate: DateTime.utc(2000, 1, 1),
      acceptTerms: true,
      acceptNewsletter: false,
    );
    expect((await container.read(currentUserProvider.future)).firstName, 'Awa');
  });

  test(
    'Review focus : profil refusé sans conditions ou trop jeune, puis accepté',
    () async {
      final container = createTestContainer();
      final actions = container.read(authActionsProvider.notifier);
      final noTerms = await actions.saveProfile(
        firstName: 'Awa',
        lastName: 'Dossou',
        birthDate: DateTime.utc(2000, 1, 1),
        acceptTerms: false,
        acceptNewsletter: false,
      );
      expect(
        (noTerms as Err).failure,
        const ValidationFailure(
          'Vous devez accepter les conditions générales.',
        ),
      );
      final tooYoung = await actions.saveProfile(
        firstName: 'Awa',
        lastName: 'Dossou',
        birthDate: DateTime.utc(fixedNow.year - 17, 1, 1),
        acceptTerms: true,
        acceptNewsletter: false,
      );
      expect(
        (tooYoung as Err).failure,
        const ValidationFailure('Vous devez avoir au moins 18 ans.'),
      );
      final ok = await actions.saveProfile(
        firstName: 'Awa',
        lastName: 'Dossou',
        birthDate: DateTime.utc(2000, 1, 1),
        acceptTerms: true,
        acceptNewsletter: true,
      );
      expect((ok as Success<UserProfile>).value.firstName, 'Awa');
      expect(
        (await container.read(currentUserProvider.future)).firstName,
        'Awa',
      );
    },
  );

  test('KYC : recto et verso exigés, puis en attente', () async {
    final container = createTestContainer();
    final actions = container.read(authActionsProvider.notifier);
    final missing = await actions.submitKyc();
    expect(
      (missing as Err).failure,
      const ValidationFailure('Photographiez le recto et le verso.'),
    );
    container.read(entryDraftControllerProvider.notifier)
      ..setDocument('passport', 'BJ')
      ..markCaptured(front: true)
      ..markCaptured(front: false);
    final captured = container.read(entryDraftControllerProvider);
    expect(captured.frontCaptured, isTrue);
    expect(captured.backCaptured, isTrue);
    expect(captured.documentType, 'passport');
    final submitted = await actions.submitKyc();
    expect((submitted as Success<KycState>).value.status, KycStatus.pending);
    expect(
      (await container.read(kycStateProvider.future)).status,
      KycStatus.pending,
    );
  });

  test(
    'limite des 18 ans : la veille du 18e anniversaire refusée, le jour même accepté',
    () async {
      final container = createTestContainer();
      final actions = container.read(authActionsProvider.notifier);
      final eighteenth = DateTime.utc(
        fixedNow.year - 18,
        fixedNow.month,
        fixedNow.day,
      );
      final dayBefore18 = eighteenth.add(const Duration(days: 1));
      final refused = await actions.saveProfile(
        firstName: 'Awa',
        lastName: 'Dossou',
        birthDate: dayBefore18,
        acceptTerms: true,
        acceptNewsletter: false,
      );
      expect(
        (refused as Err).failure,
        const ValidationFailure('Vous devez avoir au moins 18 ans.'),
      );
      final accepted = await actions.saveProfile(
        firstName: 'Awa',
        lastName: 'Dossou',
        birthDate: eighteenth,
        acceptTerms: true,
        acceptNewsletter: false,
      );
      expect(accepted, isA<Success<UserProfile>>());
    },
  );
}
