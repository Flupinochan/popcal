import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/schedule_day.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

part 'calendar_schedule.freezed.dart';

/// 配列や複数値はfreezedにする
@freezed
sealed class CalendarSchedule with _$CalendarSchedule {
  const factory CalendarSchedule({
    required Rotation rotation,
    required Map<DateKey, ScheduleDay> scheduleMap,
  }) = _CalendarSchedule;

  const CalendarSchedule._();
}
