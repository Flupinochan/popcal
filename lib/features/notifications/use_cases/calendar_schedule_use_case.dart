import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_response.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_group_response.dart';

class CalendarScheduleUseCase {
  final RotationCalculationService _rotationCalculationService;

  CalendarScheduleUseCase(this._rotationCalculationService);

  // 2. カレンダー表示用DTO作成
  /// 表示用データの生成、これはapplication service
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  /// ※1. 実際の通知設定は30日分だが、カレンダーは過去1年から未来1年まで表示
  /// ※2. 最初の通知予定日以降を表示、過去の表示は通知したことのある最初の通知予定日以降の過去のみ
  /// [rotationGroupDto]
  /// [toDate] デフォルトは未来1年分
  /// 2. Calendar表示用スケジュールを生成 ※1年分
  @override
  Result<Map<String, CalendarDayViewModel>> buildCalendarSchedule({
    required RotationGroupResponse rotationGroupDto,
    DateTime? toDate,
  }) {
    try {
      final currentTime = DateTime.now();
      final defaultToDate =
          toDate ??
          DateTime(currentTime.year + 1, currentTime.month, currentTime.day);

      final calendarDays = <String, CalendarDayViewModel>{};
      var currentIndex = rotationGroupDto.currentRotationIndex;

      // 指定期間をループしてカレンダー日を作成
      for (
        var checkDate = rotationGroupDto.createdAt;
        checkDate.isBefore(defaultToDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        if (_rotationCalculationService.isValidNotificationDate(
          checkDate: checkDate,
          rotationDays: rotationGroupDto.rotationDays,
          notificationTime: rotationGroupDto.notificationTime,
          createdAt: rotationGroupDto.createdAt,
        )) {
          final memberIndex =
              currentIndex % rotationGroupDto.rotationMembers.length;
          final memberName = rotationGroupDto.rotationMembers[memberIndex];

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
    required Map<String, CalendarDayViewModel> calendarDays,
    required DateTime date,
    String? memberName,
    required bool isRotationDay,
    int? calendarDayColorIndex,
  }) {
    final calendarDay = CalendarDayViewModel(
      date: date,
      memberName: memberName,
      isRotationDay: isRotationDay,
      memberColorIndex: calendarDayColorIndex,
    );
    final key = TimeUtils.createDateKey(date);
    calendarDays[key] = calendarDay;
  }
}
