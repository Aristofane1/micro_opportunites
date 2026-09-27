/// Échec typé renvoyé par la couche data. `message` est destiné à l'utilisateur.
sealed class Failure {
  const Failure();

  String get message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  String get message => 'Pas de connexion. Vérifiez votre réseau et réessayez.';

  @override
  bool operator ==(Object other) => other.runtimeType == NetworkFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class ServerFailure extends Failure {
  const ServerFailure({this.code});

  final String? code;

  @override
  String get message =>
      'Le service est momentanément indisponible. Réessayez dans un instant.';

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.code == code;

  @override
  int get hashCode => Object.hash(runtimeType, code);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();

  @override
  String get message => 'Votre session a expiré. Reconnectez-vous.';

  @override
  bool operator ==(Object other) => other.runtimeType == UnauthorizedFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class ValidationFailure extends Failure {
  const ValidationFailure(this.message);

  @override
  final String message;

  @override
  bool operator ==(Object other) =>
      other is ValidationFailure && other.message == message;

  @override
  int get hashCode => Object.hash(runtimeType, message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([this.error, this.stackTrace]);

  final Object? error;
  final StackTrace? stackTrace;

  @override
  String get message => 'Une erreur inattendue est survenue.';

  /// Égalité par identité de [error] (pas par contenu : une `StackTrace`
  /// ou une exception arbitraire n'a pas d'égalité de valeur fiable).
  @override
  bool operator ==(Object other) =>
      other is UnknownFailure && other.error == error;

  @override
  int get hashCode => Object.hash(runtimeType, error);
}
