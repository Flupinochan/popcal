import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';

extension type NotificationDateTime(DateTime value) {
  factory NotificationDateTime.fromDateAndTime({
    required DateKey date,
    required NotificationTime notificationTime,
  }) {
    return NotificationDateTime(
      DateTime(
        date.value.year,
        date.value.month,
        date.value.day,
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
