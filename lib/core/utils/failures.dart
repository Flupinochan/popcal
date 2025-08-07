sealed class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// 最低限featureごとに定義
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class CalendarFailure extends Failure {
  const CalendarFailure(super.message);
}

class DrawerFailure extends Failure {
  const DrawerFailure(super.message);
}

class HomeFailure extends Failure {
  const HomeFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}

class RotationFailure extends Failure {
  const RotationFailure(super.message);
}
