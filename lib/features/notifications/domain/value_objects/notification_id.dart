import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

// ignore: prefer-match-file-name
class NotificationIdConverter implements JsonConverter<NotificationId, int> {
  const NotificationIdConverter();

  @override
  NotificationId fromJson(int json) => NotificationId(json);

  @override
  int toJson(NotificationId object) => object.value;
}

extension type NotificationId(int value) {
  factory NotificationId.create(RotationId rotationId, DateTime date) {
    final rotationHash = rotationId.hashCode.abs() % 100000;
    final dateValue = date.year % 100 * 10000 + date.month * 100 + date.day;
    return NotificationId(rotationHash * 1000000 + dateValue);
  }
}
