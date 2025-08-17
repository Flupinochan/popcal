import 'package:popcal/features/calendar/domain/enum/member_color.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

class CalendarSchedule {
  const CalendarSchedule({required this.rotation, required this.scheduleMap});

  final Rotation rotation;
  // カレンダーの各日付: 各日付の表示用データ
  final Map<DateKey, ScheduleDay> scheduleMap;
}

class ScheduleDay {
  const ScheduleDay({
    required this.date,
    required this.memberName,
    required this.scheduleType,
    required this.memberColor,
    required this.canSkipNext,
    required this.canSkipPrevious,
    required this.canDisableHoliday,
    required this.canEnableHoliday,
    required this.isValidRotationDay,
  });
  final NotificationDateTime date;
  final RotationMemberName memberName;
  final DayType scheduleType;
  final MemberColor memberColor;
  final bool canSkipNext;
  final bool canSkipPrevious;
  final bool canDisableHoliday;
  final bool canEnableHoliday;
  final bool isValidRotationDay;

  String get displayText => scheduleType.displayText;
}
