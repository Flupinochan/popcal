import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

class CalendarSchedule {
  final Rotation rotation;
  // 各日付のkey: 各日付の表示用データValue
  final Map<DateKey, ScheduleDay> scheduleMap;

  const CalendarSchedule({required this.rotation, required this.scheduleMap});

  ScheduleDay getDayInfo(DateTime date) {
    return scheduleMap[NotificationDateTime(date)] ??
        ScheduleDay(
          date: NotificationDateTime(date),
          memberName: RotationMemberName('ローテーション対象外'),
          isRotationDay: false,
          memberColorIndex: null,
        );
  }
}

class ScheduleDay {
  final NotificationDateTime date;
  final RotationMemberName memberName;
  final bool isRotationDay;
  final int? memberColorIndex;

  const ScheduleDay({
    required this.date,
    required this.memberName,
    required this.isRotationDay,
    required this.memberColorIndex,
  });
}
