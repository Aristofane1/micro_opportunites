import 'package:micro_opportunites/core/error/failure.dart';

/// Résultat d'une opération : succès avec valeur, ou échec typé.
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = Err<T>;

  bool get isSuccess => this is Success<T>;

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    return switch (this) {
      Success(:final value) => onSuccess(value),
      Err(:final failure) => onFailure(failure),
    };
  }

  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success(:final value) => Success(transform(value)),
      Err(:final failure) => Err(failure),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Success<T> && other.value == value);

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Err<T> && other.failure == failure);

  @override
  int get hashCode => Object.hash(runtimeType, failure);
}
