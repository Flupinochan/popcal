import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';

part 'calendar_schedule_response.freezed.dart';

@freezed
sealed class CalendarScheduleResponse with _$CalendarScheduleResponse {
  const factory CalendarScheduleResponse({
    required RotationResponse rotationResponse,
    required Map<DateKey, ScheduleDayResponse> scheduleMap,
  }) = _CalendarScheduleResponse;
  const CalendarScheduleResponse._();

  // 指定した日付から表示用データを返却
  // 対応する表示用データがない場合は、notRotationDayを示す
  // ※全日付データ返却は重いため、Domainロジックに含めない
  ScheduleDayResponse getDayInfo(DateTime date) {
    final dateKey = DateKey.fromDateTime(date);
    return scheduleMap[dateKey] ??
        ScheduleDayResponse(
          date: NotificationDateTime(date),
          memberName: RotationMemberName.notApplicable,
          scheduleDayType: DayType.notRotationDay,
          memberColor: MemberColor.notApplicable,
          displayText: DayType.notRotationDay.displayText,
          canSkipNext: false,
          canSkipPrevious: false,
          canDisableHoliday: false,
          canEnableHoliday: false,
          isValidRotationDay: false,
        );
  }
}

// 各日付表示用データ
@freezed
sealed class ScheduleDayResponse with _$ScheduleDayResponse {
  const factory ScheduleDayResponse({
    required NotificationDateTime date,
    required RotationMemberName memberName,
    required DayType scheduleDayType,
    required MemberColor memberColor,
    required String displayText,
    required bool canSkipNext,
    required bool canSkipPrevious,
    required bool canDisableHoliday,
    required bool canEnableHoliday,
    required bool isValidRotationDay,
  }) = _ScheduleDayResponse;

  const ScheduleDayResponse._();
}
