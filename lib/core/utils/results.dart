final class Error<T> extends Result<T> {
  const Error._(this.error);
  @override
  final Exception error;
  @override
  String toString() => 'Result<$T>.error($error)';
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);
  @override
  final T value;
  @override
  String toString() => 'Result<$T>.ok($value)';
}

sealed class Result<T> {
  const Result();

  const factory Result.error(Exception error) = Error._;
  const factory Result.ok(T value) = Ok._;

  Exception get error => switch (this) {
    Ok() => throw StateError('Called error on Ok result'),
    Error(:final error) => error,
  };

  bool get isError => this is Error<T>;

  T get value => switch (this) {
    Ok(:final value) => value,
    Error() => throw StateError('Called value on Error result'),
  };
}
