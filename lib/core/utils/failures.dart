/// エラーの種類を定義
sealed class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

// バリデーションエラー
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// 認証エラー
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// ネットワークエラー
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// 通知設定エラー
class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}
