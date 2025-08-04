import 'package:flutter/material.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_day.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_plan.dart';

class ScheduleCalculationServiceImpl implements ScheduleCalculationService {
  /// 1. 次回の通知予定日を計算
  @override
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime fromDate,
  }) {
    // 曜日指定のローテーション機能であり、遅くても未来7日後までに最初の通知日があるはず
    // 判定開始日は+0日で、今から未来+8日分をチェックが妥当だが
    // 拡張性を考え未来1年分(+365)は計算可能にする ※whileはリスクがあるため利用しない
    for (
      var checkDate = fromDate;
      checkDate.isBefore(fromDate.add(const Duration(days: 365)));
      // checkDate.isBefore(fromDate.add(const Duration(days: 8)));
      checkDate = checkDate.add(const Duration(days: 1))
    ) {
      if (_isValidNotificationDate(
        checkDate: checkDate,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        createdAt: fromDate,
      )) {
        return Results.success(checkDate);
      }
    }
    return Results.failure(ValidationFailure('次回ローテーション日の取得に失敗しました'));
  }

  /// 2. Calendar表示用スケジュールを生成 ※1年分
  @override
  Result<Map<String, CalendarDay>> buildCalendarSchedule({
    required RotationGroup rotationGroup,
    DateTime? toDate,
  }) {
    try {
      final currentTime = DateTime.now();
      final defaultToDate =
          toDate ??
          DateTime(currentTime.year + 1, currentTime.month, currentTime.day);

      final calendarDays = <String, CalendarDay>{};
      var currentIndex = rotationGroup.currentRotationIndex;

      // 指定期間をループしてカレンダー日を作成
      for (
        var checkDate = rotationGroup.createdAt;
        checkDate.isBefore(defaultToDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        if (_isValidNotificationDate(
          checkDate: checkDate,
          rotationDays: rotationGroup.rotationDays,
          notificationTime: rotationGroup.notificationTime,
          createdAt: rotationGroup.createdAt,
        )) {
          final memberIndex =
              currentIndex % rotationGroup.rotationMembers.length;
          final memberName = rotationGroup.rotationMembers[memberIndex];

          _addCalendarDay(
            calendarDays: calendarDays,
            date: checkDate,
            memberName: memberName,
            isRotationDay: true,
          );

          currentIndex++;
        } else {
          // ローテーション対象外の日
          _addCalendarDay(
            calendarDays: calendarDays,
            date: checkDate,
            memberName: null,
            isRotationDay: false,
          );
        }
      }

      return Results.success(calendarDays);
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダーの作成に失敗しました: $error'));
    }
  }

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  @override
  Result<NotificationPlan> planUpcomingNotifications({
    required RotationGroup rotationGroup,
    int futureDays = 30,
  }) {
    try {
      // 現在時刻をベース
      final currentTime = DateTime.now().toLocal();
      final toDate = currentTime.add(Duration(days: futureDays));

      final notifications = <NotificationSetting>[];
      var currentIndex = rotationGroup.currentRotationIndex;

      // 指定期間をループして通知情報を作成
      for (
        var checkDate = currentTime;
        checkDate.isBefore(toDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        if (_isValidNotificationDate(
          checkDate: checkDate,
          rotationDays: rotationGroup.rotationDays,
          notificationTime: rotationGroup.notificationTime,
          createdAt: currentTime,
        )) {
          final memberIndex =
              currentIndex % rotationGroup.rotationMembers.length;
          final memberName = rotationGroup.rotationMembers[memberIndex];
          final notificationId = _generateNotificationId(
            rotationGroup.rotationGroupId!,
            checkDate,
          );
          final scheduledDateTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            rotationGroup.notificationTime.hour,
            rotationGroup.notificationTime.minute,
          );

          final notificationSetting = NotificationSetting(
            notificationId: notificationId,
            rotationGroupId: rotationGroup.rotationGroupId!,
            userId: rotationGroup.userId,
            rotationName: rotationGroup.rotationName,
            notificationTime: scheduledDateTime,
            memberName: memberName,
            rotationStartDate: rotationGroup.createdAt,
          );

          notifications.add(notificationSetting);
          currentIndex++;
        }
      }

      return Results.success(
        NotificationPlan(
          notificationSettings: notifications,
          newCurrentRotationIndex: currentIndex,
        ),
      );
    } catch (error) {
      return Results.failure(NotificationFailure('通知予定の作成に失敗しました: $error'));
    }
  }

  /// ローテーション日判定
  bool _isValidNotificationDate({
    required DateTime checkDate,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime createdAt,
  }) {
    final checkDay = Weekday.fromDateTime(checkDate);

    // ローテーション曜日の場合
    if (rotationDays.contains(checkDay)) {
      final notificationDateTime = DateTime(
        checkDate.year,
        checkDate.month,
        checkDate.day,
        notificationTime.hour,
        notificationTime.minute,
      );
      // ※作成日がローテーション曜日の場合でも、すでに時刻が過ぎている場合は、ローテーション日に含めない
      // そのため、曜日だけでなく時刻を含めて比較
      if (notificationDateTime.isAfter(createdAt)) {
        return true;
      }
    }
    return false;
  }

  void _addCalendarDay({
    required Map<String, CalendarDay> calendarDays,
    required DateTime date,
    String? memberName,
    required bool isRotationDay,
  }) {
    final calendarDay = CalendarDay(
      date: date,
      memberName: memberName,
      isRotationDay: isRotationDay,
    );
    final key = TimeUtils.createDateKey(date);
    calendarDays[key] = calendarDay;
  }

  /// 通知IDを生成 ※日付ベース
  int _generateNotificationId(String rotationGroupId, DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }
}
