import 'package:fpdart/fpdart.dart';
import 'package:popcal/core/utils/failure.dart';

/// 共通の処理結果返却クラス
/// 1. 成功時は、そのままTを返却
/// 2. 失敗時は、Failureを返却
typedef Result<T> = Either<Failure, T>;

class Results {
  static Result<T> failure<T>(Failure failure) => Left(failure);
  static Future<Result<T>> failureAsync<T>(Failure failure) async =>
      Left(failure);

  static Result<T> success<T>(T value) => Right(value);
  static Future<Result<T>> successAsync<T>(T value) async => Right(value);
}

extension ResultExtensions<T> on Result<T> {
  // 失敗 テキスト取得
  String get displayText {
    return fold((failure) => failure.toString(), (value) => value.toString());
  }

  Failure? get failureOrNull => fold((failure) => failure, (_) => null);
  bool get isFailure => isLeft();

  // 成功/失敗 boolean取得
  bool get isSuccess => isRight();
  // 成功/失敗 値取得
  T? get valueOrNull => fold((_) => null, (value) => value);

  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) {
    return fold(failure, success);
  }
}
