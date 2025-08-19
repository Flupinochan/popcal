import 'package:intl/intl.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

extension type NotificationDateTime._(DateTime value) {
  factory NotificationDateTime.fromDateKeyAndNotificationTime({
    required DateKey date,
    required NotificationTime notificationTime,
  }) {
    return NotificationDateTime._(
      DateTime(
        date.value.year,
        date.value.month,
        date.value.day,
        notificationTime.hour,
        notificationTime.minute,
      ),
    );
  }

  String getDisplayDeadline() {
    final formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(value);
    return '$formattedDate ${Weekday.fromInt(value.weekday).displayName}曜日';
  }

  String getMonth() {
    return value.month.toString();
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

  static Result<NotificationDateTime> create(DateTime input) {
    return Results.success(NotificationDateTime._(input));
  }
}
