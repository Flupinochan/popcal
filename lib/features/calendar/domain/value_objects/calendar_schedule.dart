import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

class CalendarSchedule {
  final Rotation rotation;
  // 各日付のkey: 各日付の表示用データValue
  final Map<DateKey, ScheduleDay> scheduleMap;

  const CalendarSchedule({required this.rotation, required this.scheduleMap});

  ScheduleDay getDayInfo(DateTime date) {
    final key = DateKey.fromDateTime(date);
    return scheduleMap[key] ??
        ScheduleDay(
          date: date,
          memberName: null,
          isRotationDay: false,
          memberColorIndex: null,
        );
  }
}

class ScheduleDay {
  final DateTime date;
  final String? memberName;
  final bool isRotationDay;
  final int? memberColorIndex;

  const ScheduleDay({
    required this.date,
    required this.memberName,
    required this.isRotationDay,
    required this.memberColorIndex,
  });
}
