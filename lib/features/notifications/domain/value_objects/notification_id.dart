import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

class NotificationIdConverter implements JsonConverter<NotificationId, int> {
  const NotificationIdConverter();

  @override
  NotificationId fromJson(int json) => NotificationId(json);

  @override
  int toJson(NotificationId object) => object.value;
}

extension type NotificationId(int value) {
  factory NotificationId.create(RotationId rotationId, DateTime date) {
    final combined = '$rotationId-${date.year}-${date.month}-${date.day}';
    return NotificationId(combined.hashCode.abs() % 2147483647);
  }
}
