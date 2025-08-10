import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';

part 'calendar_schedule_response.freezed.dart';

@freezed
sealed class CalendarScheduleResponse with _$CalendarScheduleResponse {
  const CalendarScheduleResponse._();

  const factory CalendarScheduleResponse({
    required RotationResponse rotationResponse,
    required Map<DateKey, ScheduleDayResponse> scheduleMap,
  }) = _CalendarScheduleResponse;

  // 指定した日付から表示用データを返却
  ScheduleDayResponse getDayInfo(DateTime date) {
    final dateKey = DateKey.fromDateTime(date);
    return scheduleMap[dateKey] ??
        ScheduleDayResponse(
          date: NotificationDateTime(date),
          memberName: RotationMemberName.notApplicable,
          isRotationDay: false,
          memberColor: MemberColor.notApplicable,
        );
  }
}

// 各日付表示用データ
@freezed
sealed class ScheduleDayResponse with _$ScheduleDayResponse {
  const ScheduleDayResponse._();

  const factory ScheduleDayResponse({
    required NotificationDateTime date,
    required RotationMemberName memberName,
    required bool isRotationDay,
    required MemberColor memberColor,
  }) = _ScheduleDayResponse;

  String get displayText => isRotationDay ? "担当日" : "対象外";
}
