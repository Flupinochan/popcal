import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

extension type NotificationDescription._(String value) {
  static Result<NotificationDescription> createForDeadline(int input) {
    if (input < 1 || input > 12) {
      return const Result.error(ValidationException('1月から12月の範囲で指定してください'));
    }

    return Result.ok(NotificationDescription._('$input月の最終平日です'));
  }

  static NotificationDescription createForRotation(RotationName input) {
    return NotificationDescription._('$inputの通知');
  }

  static NotificationDescription createFromLocal(String input) {
    return NotificationDescription._(input);
  }
}
