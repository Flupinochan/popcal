import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';

extension type NotificationDateTime(DateTime value) {
  factory NotificationDateTime.now() => NotificationDateTime(DateTime.now());

  factory NotificationDateTime.fromDateAndTime({
    required DateTime date,
    required NotificationTime notificationTime,
  }) {
    return NotificationDateTime(
      DateTime(
        date.year,
        date.month,
        date.day,
        notificationTime.value.hour,
        notificationTime.value.minute,
      ),
    );
  }

  bool isBeforeDateTime(DateTime datetime) {
    return value.isBefore(datetime);
  }

  bool isAfterRotationDateTime(RotationDateTime rotationDateTime) {
    return value.isAfter(rotationDateTime.dateTime);
  }
}

class NotificationDateConverter
    implements JsonConverter<NotificationDateTime, String> {
  const NotificationDateConverter();

  @override
  NotificationDateTime fromJson(String json) =>
      NotificationDateTime(DateTime.parse(json));

  @override
  String toJson(NotificationDateTime object) => object.value.toIso8601String();
}
