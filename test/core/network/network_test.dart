import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/core/network/guard.dart';

void main() {
  test('failureFromError traduit les erreurs HTTP', () {
    expect(
      failureFromError(const ApiException(0, 'hors-ligne')),
      isA<NetworkFailure>(),
    );
    expect(
      failureFromError(const ApiException(401, 'x')),
      isA<UnauthorizedFailure>(),
    );
    final validation = failureFromError(
      const ApiException(409, 'Vous avez déjà postulé à cette mission.'),
    );
    expect(
      validation,
      const ValidationFailure('Vous avez déjà postulé à cette mission.'),
    );
    expect(
      failureFromError(const ApiException(503, 'x')),
      const ServerFailure(code: '503'),
    );
    expect(failureFromError(StateError('boom')), isA<UnknownFailure>());
    expect(failureFromError(const NetworkFailure()), const NetworkFailure());
  });

  test('guardResult enveloppe succès et erreurs', () async {
    expect(await guardResult(() async => 3), const Success(3));
    final failed = await guardResult<int>(
      () async => throw const ApiException(0, 'x'),
    );
    expect(failed, const Err<int>(NetworkFailure()));
  });
}
