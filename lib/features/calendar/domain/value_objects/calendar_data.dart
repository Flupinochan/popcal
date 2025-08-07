import 'package:popcal/features/calendar/presentation/dto/calendar_response.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

class CalendarData {
  final Rotation rotation;
  // 各日付のkey: 各日付の表示用データValue
  final Map<DateKey, CalendarDay> dayInfoMap;

  const CalendarData({required this.rotation, required this.dayInfoMap});

  CalendarDay getDayInfo(DateTime date) {
    final key = DateKey.fromDateTime(date);
    return dayInfoMap[key] ??
        CalendarDay(
          date: date,
          memberName: null,
          isRotationDay: false,
          memberColorIndex: null,
        );
  }
}

class CalendarDay {
  final DateTime date;
  final String? memberName;
  final bool isRotationDay;
  final int? memberColorIndex;

  const CalendarDay({
    required this.date,
    required this.memberName,
    required this.isRotationDay,
    required this.memberColorIndex,
  });
}
