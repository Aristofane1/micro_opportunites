import 'package:micro_opportunites/core/error/failure.dart';

/// Échec d'un appel API. `statusCode` 0 = pas de réseau.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode, $message)';
}

/// Traduit n'importe quelle erreur en [Failure] affichable.
Failure failureFromError(Object error, [StackTrace? stackTrace]) {
  return switch (error) {
    Failure() => error,
    ApiException(statusCode: 0) => const NetworkFailure(),
    ApiException(statusCode: 401 || 403) => const UnauthorizedFailure(),
    ApiException(statusCode: 400 || 404 || 409 || 422, :final message) =>
      ValidationFailure(message),
    ApiException(:final statusCode) when statusCode >= 500 => ServerFailure(
      code: '$statusCode',
    ),
    _ => UnknownFailure(error, stackTrace),
  };
}
