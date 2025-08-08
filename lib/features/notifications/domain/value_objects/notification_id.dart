import 'package:freezed_annotation/freezed_annotation.dart';

extension type NotificationId(int value) {
  factory NotificationId.create(String rotationId, DateTime date) {
    return NotificationId(date.year * 10000 + date.month * 100 + date.day);
  }
}

class NotificationIdConverter implements JsonConverter<NotificationId, int> {
  const NotificationIdConverter();

  @override
  NotificationId fromJson(int json) => NotificationId(json);

  @override
  int toJson(NotificationId object) => object.value;
}
