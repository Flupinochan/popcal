import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

extension type NotificationContent._(String value) {
  static Result<NotificationContent> createForDeadline(int input) {
    if (input < 1 || input > 12) {
      return Results.failure(const ValidationFailure('1月から12月の範囲で指定してください'));
    }

    return Results.success(NotificationContent._('$input月の最終平日です'));
  }

  static NotificationContent createFromLocal(String input) {
    return NotificationContent._(input);
  }

  static NotificationContent createFromRotationMemberName(
    RotationMemberName input,
  ) {
    return NotificationContent._('今日は$inputの番です');
  }
}
