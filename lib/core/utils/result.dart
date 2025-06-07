import 'package:popcal/core/utils/failures.dart';

/// 共通の処理結果返却クラス
/// 1. 成功時は、そのままTを返却
/// 2. 失敗時は、Failureを返却
sealed class Result<T> {
  const Result();
  const factory Result.success(T value) = Success._;
  const factory Result.failure(Failure failure) = Error._;

  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;
}

/// 成功
final class Success<T> extends Result<T> {
  const Success._(this.value);

  final T value;

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) => success(value);

  @override
  String toString() => '$value';
}

/// 失敗
final class Error<T> extends Result<T> {
  const Error._(this.failure);

  final Failure failure;

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) => failure(this.failure);

  @override
  String toString() => '$failure';
}


// 使用例
// Future<Result<User>> signIn(String email, String password) async {
//   if (!_isValidEmail(email)) {
//     return Result.failure(ValidationFailure('無効なメールアドレス'));
//   }

//   try {
//     final user = await repository.signIn(email, password);
//     return Result.success(user);
//   } catch (e) {
//     return Result.failure(AuthFailure('認証に失敗しました'));
//   }
// }

// // 呼び出し側での使用
// final result = await signIn(email, password);
// result.when(
//   success: (user) => navigateToHome(user),
//   failure: (failure) => showError(failure.message),
// );

// // 型チェック
// if (result.isSuccess) {
//   final user = (result as Success<User>).value;
//   // 成功時の処理
// }