import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';

extension type RotationCreatedAt(DateTime value) {
  bool isBeforeNotificationDateTime(NotificationDateTime notificationDate) =>
      value.isBefore(notificationDate.value);

  RotationCreatedAt add(Duration duration) =>
      RotationCreatedAt(value.add(duration));
}

class RotationCreatedAtConverter
    implements JsonConverter<RotationCreatedAt, String> {
  const RotationCreatedAtConverter();

  @override
  RotationCreatedAt fromJson(String json) =>
      RotationCreatedAt(DateTime.parse(json));

  @override
  String toJson(RotationCreatedAt object) => object.value.toIso8601String();
}
