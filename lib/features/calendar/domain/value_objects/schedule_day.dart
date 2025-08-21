import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/enum/member_color.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

part 'schedule_day.freezed.dart';

/// カレンダーの各日付表示用データ
@freezed
sealed class ScheduleDay with _$ScheduleDay {
  const factory ScheduleDay({
    required NotificationDateTime notificationDateTime,
    required RotationMemberName memberName,
    required DayType scheduleType,
    required MemberColor memberColor,
    required bool canSkipNext,
    required bool canSkipPrevious,
    required bool canDisableHoliday,
    required bool canEnableHoliday,
    required bool isValidRotationDay,
  }) = _ScheduleDay;

  const ScheduleDay._();

  String get displayText => scheduleType.displayText;
}
