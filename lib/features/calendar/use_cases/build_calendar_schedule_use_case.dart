import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class BuildCalendarScheduleUseCase {
  final RotationCalculationService _rotationCalculationService;
  final TimeUtils _timeUtils;

  BuildCalendarScheduleUseCase(
    this._rotationCalculationService,
    this._timeUtils,
  );

  // 2. カレンダー表示用DTO作成
  /// 表示用データの生成、これはapplication service
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  /// ※1. 実際の通知設定は30日分だが、カレンダーは過去1年から未来1年まで表示
  /// ※2. 最初の通知予定日以降を表示、過去の表示は通知したことのある最初の通知予定日以降の過去のみ
  /// [rotation]
  /// [toDate] デフォルトは未来1年分
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  Result<Map<DateKey, ScheduleDay>> buildCalendarSchedule({
    required Rotation rotation,
    NotificationDateTime? toDate,
  }) {
    try {
      final now = NotificationDateTime(_timeUtils.now());
      var newCurrentRotationIndex = RotationIndex(0);
      final calendarDays = <DateKey, ScheduleDay>{};
      // 指定期間をループしてカレンダー日を作成
      for (
        var checkDate = rotation.createdAt;
        checkDate.isBeforeNotificationDateTime(toDate ?? now);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        final dateKey = DateKey.fromDateTime(checkDate.value);
        final notificationTime = rotation.notificationTime;
        final notificationDateTime = NotificationDateTime.fromDateAndTime(
          date: dateKey,
          notificationTime: notificationTime,
        );

        if (_rotationCalculationService.isValidNotificationDate(
          checkDate: dateKey,
          rotationDays: rotation.rotationDays,
          notificationTime: notificationTime,
          rotationDateTime: RotationDateTime.createdAt(rotation.createdAt),
        )) {
          final memberName = rotation.getRotationMemberName(
            newCurrentRotationIndex,
          );
          final memberIndex = rotation.getRotationMemberIndex(
            newCurrentRotationIndex,
          );

          _addCalendarDay(
            calendarDays: calendarDays,
            date: notificationDateTime,
            memberName: memberName,
            isRotationDay: true,
            memberColor: MemberColor.fromIndex(memberIndex),
          );

          newCurrentRotationIndex = newCurrentRotationIndex.increment();
        } else {
          // ローテーション対象外の日
          _addCalendarDay(
            calendarDays: calendarDays,
            date: notificationDateTime,
            memberName: RotationMemberName.notApplicable,
            isRotationDay: false,
            memberColor: MemberColor.notApplicable,
          );
        }
      }

      return Results.success(calendarDays);
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダーの作成に失敗しました: $error'));
    }
  }

  void _addCalendarDay({
    required Map<DateKey, ScheduleDay> calendarDays,
    required NotificationDateTime date,
    required RotationMemberName memberName,
    required bool isRotationDay,
    required MemberColor memberColor,
  }) {
    final dateKey = DateKey.fromDateTime(date.value);

    final calendarDay = ScheduleDay(
      date: date,
      memberName: memberName,
      isRotationDay: isRotationDay,
      memberColor: memberColor,
    );
    calendarDays[dateKey] = calendarDay;
  }
}
