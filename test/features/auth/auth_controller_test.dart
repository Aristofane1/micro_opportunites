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
  test('demande de code : code de démo et numéro masqué', () async {
    final container = createTestContainer();
    final result = await container.read(authActionsProvider.notifier).requestCode('+22997123456');
    final verification = (result as Success<PhoneVerification>).value;
    expect(verification.demoCode, '12345');
    expect(verification.maskedPhone, '+229 •• •• •• 56');
    expect(container.read(entryDraftControllerProvider).verification, verification);
  });

  test('numéro trop court refusé', () async {
    final container = createTestContainer();
    final result = await container.read(authActionsProvider.notifier).requestCode('+2291');
    expect((result as Err).failure, const ValidationFailure('Numéro de téléphone invalide.'));
  });

  test('Review focus : mauvais code puis bon code', () async {
    final container = createTestContainer();
    final actions = container.read(authActionsProvider.notifier);
    await actions.requestCode('+22997123456');
    final wrong = await actions.verifyCode('00000');
    expect((wrong as Err).failure, const ValidationFailure('Code incorrect.'));
    expect(await actions.verifyCode('12345'), isA<Success<void>>());
  });

  test('Review focus : profil refusé sans conditions ou trop jeune, puis accepté', () async {
    final container = createTestContainer();
    final actions = container.read(authActionsProvider.notifier);
    final noTerms = await actions.saveProfile(
      firstName: 'Awa', lastName: 'Dossou',
      birthDate: DateTime.utc(2000, 1, 1), acceptTerms: false, acceptNewsletter: false,
    );
    expect((noTerms as Err).failure,
        const ValidationFailure('Vous devez accepter les conditions générales.'));
    final tooYoung = await actions.saveProfile(
      firstName: 'Awa', lastName: 'Dossou',
      birthDate: DateTime.utc(fixedNow.year - 17, 1, 1), acceptTerms: true, acceptNewsletter: false,
    );
    expect((tooYoung as Err).failure, const ValidationFailure('Vous devez avoir au moins 18 ans.'));
    final ok = await actions.saveProfile(
      firstName: 'Awa', lastName: 'Dossou',
      birthDate: DateTime.utc(2000, 1, 1), acceptTerms: true, acceptNewsletter: true,
    );
    expect((ok as Success<UserProfile>).value.firstName, 'Awa');
    expect((await container.read(currentUserProvider.future)).firstName, 'Awa');
  });

  test('KYC : recto et verso exigés, puis en attente', () async {
    final container = createTestContainer();
    final actions = container.read(authActionsProvider.notifier);
    final missing = await actions.submitKyc();
    expect((missing as Err).failure, const ValidationFailure('Photographiez le recto et le verso.'));
    final draft = container.read(entryDraftControllerProvider.notifier)
      ..setDocument('passport', 'BJ')
      ..markCaptured(front: true)
      ..markCaptured(front: false);
    expect(draft, isNotNull);
    final submitted = await actions.submitKyc();
    expect((submitted as Success<KycState>).value.status, KycStatus.pending);
    expect((await container.read(kycStateProvider.future)).status, KycStatus.pending);
  });
}
