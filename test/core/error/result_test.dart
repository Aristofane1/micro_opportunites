import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/error/result.dart';

void main() {
  test('Success expose sa valeur par pattern matching', () {
    const Result<int> result = Result.success(3);
    expect(result.isSuccess, isTrue);
    final value = switch (result) {
      Success(:final value) => value,
      Err() => -1,
    };
    expect(value, 3);
  });

  test('fold choisit la bonne branche', () {
    const Result<int> ok = Success(2);
    const Result<int> ko = Err(NetworkFailure());
    expect(ok.fold(onSuccess: (v) => 'v$v', onFailure: (f) => 'f'), 'v2');
    expect(
      ko.fold(onSuccess: (v) => 'v', onFailure: (f) => f.message),
      const NetworkFailure().message,
    );
  });

  test('map transforme un succès et propage un échec', () {
    const Result<int> ok = Success(2);
    const Result<int> ko = Err(ValidationFailure('Titre requis'));
    expect((ok.map((v) => v * 10) as Success<int>).value, 20);
    final mapped = ko.map((v) => v * 10);
    expect(mapped.isSuccess, isFalse);
    expect((mapped as Err<int>).failure.message, 'Titre requis');
  });

  test('M6 : Review focus : Success compare par valeur', () {
    // Valeurs passées via des variables (non littérales) pour que chaque
    // Success(...) soit une instance distincte, pas un const canonicalisé :
    // on veut exercer operator== au-delà du raccourci `identical`.
    final one = int.parse('1');
    final anotherOne = int.parse('1');
    final two = int.parse('2');
    expect(Success(one), Success(anotherOne));
    expect(Success(one).hashCode, Success(anotherOne).hashCode);
    expect(Success(one), isNot(Success(two)));
    expect(Success<int>(one), isNot(Success<String>(one.toString())));
  });

  test('M6 : Review focus : Err compare par valeur (Failure incluse)', () {
    final x = 'x'.toString();
    final anotherX = 'x'.toString();
    final y = 'y'.toString();
    expect(
      Err<int>(ValidationFailure(x)),
      Err<int>(ValidationFailure(anotherX)),
    );
    expect(
      Err<int>(ValidationFailure(x)),
      isNot(Err<int>(ValidationFailure(y))),
    );
    expect(const Err<int>(NetworkFailure()), const Err<int>(NetworkFailure()));
  });

  test('M6 : Review focus : ServerFailure compare par code, UnknownFailure '
      'par identité de l’erreur', () {
    final a = 'a'.toString();
    final anotherA = 'a'.toString();
    final b = 'b'.toString();
    expect(ServerFailure(code: a), ServerFailure(code: anotherA));
    expect(ServerFailure(code: a), isNot(ServerFailure(code: b)));
    final error = StateError('boom');
    expect(UnknownFailure(error), UnknownFailure(error));
    expect(UnknownFailure(error), isNot(UnknownFailure(StateError('boom'))));
  });

  test('chaque Failure a un message français non vide', () {
    final failures = <Failure>[
      const NetworkFailure(),
      const ServerFailure(code: 'unavailable'),
      const UnauthorizedFailure(),
      const ValidationFailure('Numéro incomplet'),
      UnknownFailure(StateError('boom'), StackTrace.current),
    ];
    for (final failure in failures) {
      expect(failure.message, isNotEmpty);
    }
  });

  test('getOrThrow renvoie la valeur ou lève la Failure', () {
    expect(const Success(4).getOrThrow(), 4);
    expect(
      () => const Err<int>(NetworkFailure()).getOrThrow(),
      throwsA(isA<NetworkFailure>()),
    );
  });
}
