import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';

/// Exécute [body] et enveloppe le résultat : utilisé par tous les
/// repositories pour ne jamais laisser fuir d'exception vers l'UI.
Future<Result<T>> guardResult<T>(Future<T> Function() body) async {
  try {
    return Success(await body());
  } catch (error, stackTrace) {
    return Err(failureFromError(error, stackTrace));
  }
}
