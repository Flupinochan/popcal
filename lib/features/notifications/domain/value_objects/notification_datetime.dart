import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

class NotificationDateConverter
    implements JsonConverter<NotificationDateTime, String> {
  const NotificationDateConverter();

  @override
  NotificationDateTime fromJson(String json) =>
      NotificationDateTime(DateTime.parse(json));

  @override
  String toJson(NotificationDateTime object) => object.value.toIso8601String();
}

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

  DateKey toDateKey() {
    final dateKeyResult = DateKey.create(value);
    if (dateKeyResult.isFailure) {
      throw Exception(dateKeyResult.displayText);
    }
    return dateKeyResult.valueOrNull!;
  }
}
