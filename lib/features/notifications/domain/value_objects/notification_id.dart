import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

class NotificationIdConverter implements JsonConverter<NotificationId, int> {
  const NotificationIdConverter();

  @override
  NotificationId fromJson(int json) => NotificationId(json);

  @override
  int toJson(NotificationId object) => object.value;
}

extension type NotificationId(int value) {
  factory NotificationId.create(SourceId sourceId, DateTime date) {
    final combined = '$sourceId-${date.year}-${date.month}-${date.day}';
    return NotificationId(combined.hashCode.abs() % 2147483647);
  }
}
