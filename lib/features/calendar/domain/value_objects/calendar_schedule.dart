import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

class CalendarSchedule {
  const CalendarSchedule({required this.rotation, required this.scheduleMap});

  final Rotation rotation;
  // 各日付のkey: 各日付の表示用データValue
  final Map<DateKey, ScheduleDay> scheduleMap;

  ScheduleDay getDayInfo(DateTime date) {
    final dateKey = DateKey.fromDateTime(date);
    return scheduleMap[dateKey] ??
        ScheduleDay(
          date: NotificationDateTime(date),
          memberName: RotationMemberName.notApplicable,
          isRotationDay: false,
          memberColor: MemberColor.notApplicable,
        );
  }
}

class ScheduleDay {
  const ScheduleDay({
    required this.date,
    required this.memberName,
    required this.isRotationDay,
    required this.memberColor,
  });
  final NotificationDateTime date;
  final RotationMemberName memberName;
  final bool isRotationDay;
  final MemberColor memberColor;

  String get displayText => isRotationDay ? '担当日' : '対象外';
}
