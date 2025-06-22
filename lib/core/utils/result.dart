import 'package:fpdart/fpdart.dart';
import 'failures.dart';

/// 共通の処理結果返却クラス
/// 1. 成功時は、そのままTを返却
/// 2. 失敗時は、Failureを返却
typedef Result<T> = Either<Failure, T>;

class Results {
  static Result<T> success<T>(T value) => Right(value);
  static Result<T> failure<T>(Failure failure) => Left(failure);

  static Future<Result<T>> successAsync<T>(T value) async => Right(value);
  static Future<Result<T>> failureAsync<T>(Failure failure) async =>
      Left(failure);
}

extension ResultExtensions<T> on Result<T> {
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) {
    return fold(failure, success);
  }

  // 成功/失敗 boolean取得
  bool get isSuccess => isRight();
  bool get isFailure => isLeft();

  // 成功/失敗 値取得
  T? get valueOrNull => fold((_) => null, (value) => value);
  Failure? get failureOrNull => fold((failure) => failure, (_) => null);

  // 失敗 テキスト取得
  String get displayText {
    return fold((failure) => failure.toString(), (value) => value.toString());
  }
}
