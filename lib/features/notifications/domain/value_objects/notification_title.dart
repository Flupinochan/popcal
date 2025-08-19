import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

extension type NotificationTitle._(String value) {
  static NotificationTitle createDeadline() {
    return NotificationTitle._('月末営業日通知');
  }

  static NotificationTitle createFromLocal(String value) {
    return NotificationTitle._(value);
  }

  static Result<NotificationTitle> createFromRotationName(RotationName input) {
    return Results.success(NotificationTitle._(input.value));
  }
}
