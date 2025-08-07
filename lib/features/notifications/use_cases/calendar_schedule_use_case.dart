import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_data.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_response.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

class CalendarScheduleUseCase {
  final RotationCalculationService _rotationCalculationService;

  CalendarScheduleUseCase(this._rotationCalculationService);

  // 2. カレンダー表示用DTO作成
  /// 表示用データの生成、これはapplication service
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  /// ※1. 実際の通知設定は30日分だが、カレンダーは過去1年から未来1年まで表示
  /// ※2. 最初の通知予定日以降を表示、過去の表示は通知したことのある最初の通知予定日以降の過去のみ
  /// [rotation]
  /// [toDate] デフォルトは未来1年分
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  Result<Map<DateKey, CalendarDay>> buildCalendarSchedule({
    required Rotation rotation,
    DateTime? toDate,
  }) {
    try {
      final currentTime = DateTime.now();
      final defaultToDate =
          toDate ??
          DateTime(currentTime.year + 1, currentTime.month, currentTime.day);

      final calendarDays = <DateKey, CalendarDay>{};
      var currentIndex = rotation.currentRotationIndex;

      // 指定期間をループしてカレンダー日を作成
      for (
        var checkDate = rotation.createdAt;
        checkDate.isBefore(defaultToDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        if (_rotationCalculationService.isValidNotificationDate(
          checkDate: checkDate,
          rotationDays: rotation.rotationDays,
          notificationTime: rotation.notificationTime,
          createdAt: rotation.createdAt,
        )) {
          final memberIndex = currentIndex % rotation.rotationMembers.length;
          final memberName = rotation.rotationMembers[memberIndex];

          _addCalendarDay(
            calendarDays: calendarDays,
            date: checkDate,
            memberName: memberName,
            isRotationDay: true,
            calendarDayColorIndex: memberIndex,
          );

          currentIndex++;
        } else {
          // ローテーション対象外の日
          _addCalendarDay(
            calendarDays: calendarDays,
            date: checkDate,
            memberName: null,
            isRotationDay: false,
            calendarDayColorIndex: null,
          );
        }
      }

      return Results.success(calendarDays);
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダーの作成に失敗しました: $error'));
    }
  }

  void _addCalendarDay({
    required Map<DateKey, CalendarDay> calendarDays,
    required DateTime date,
    String? memberName,
    required bool isRotationDay,
    int? calendarDayColorIndex,
  }) {
    final calendarDay = CalendarDay(
      date: date,
      memberName: memberName,
      isRotationDay: isRotationDay,
      memberColorIndex: calendarDayColorIndex,
    );
    final key = DateKey.fromDateTime(date);
    calendarDays[key] = calendarDay;
  }
}
