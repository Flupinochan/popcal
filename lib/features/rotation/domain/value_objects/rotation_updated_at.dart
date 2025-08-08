import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';

extension type RotationUpdatedAt(DateTime value) {
  bool isBeforeNotificationDateTime(NotificationDateTime notificationDate) =>
      value.isBefore(notificationDate.value);

  RotationUpdatedAt add(Duration duration) =>
      RotationUpdatedAt(value.add(duration));
}

class RotationUpdatedAtConverter
    implements JsonConverter<RotationUpdatedAt, String> {
  const RotationUpdatedAtConverter();

  @override
  RotationUpdatedAt fromJson(String json) =>
      RotationUpdatedAt(DateTime.parse(json));

  @override
  String toJson(RotationUpdatedAt object) => object.value.toIso8601String();
}
