import 'package:flutter/material.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_day.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

class ScheduleCalculationServiceImpl implements ScheduleCalculationService {
  /// 1. 最初の通知予定日を計算
  @override
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    DateTime? currentTime,
  }) {
    final now = DateTime.now();
    final defaultCurrentTime =
        currentTime ?? DateTime(now.year - 1, now.month, now.day);

    // 曜日指定のローテーション機能であり、遅くても未来7日後までに最初の通知日があるはず
    for (
      var checkDate = defaultCurrentTime;
      checkDate.isBefore(defaultCurrentTime.add(const Duration(days: 7)));
      checkDate = checkDate.add(const Duration(days: 1))
    ) {
      // 開始日は+0日で、今から未来+7日分をチェック
      final checkDay = Weekday.fromDateTime(checkDate);

      // ローテーション日に含まれる かつ 今より未来の時刻の場合
      if (rotationDays.contains(checkDay) &&
          checkDate.isAfter(defaultCurrentTime)) {
        return Results.success(checkDate);
      }
    }
    return Results.failure(ValidationFailure('次回ローテーション日の取得に失敗しました'));
  }

  /// 2. Calendar表示用スケジュールを生成 ※1年分
  @override
  Result<Map<String, CalendarDay>> buildCalendarSchedule({
    required RotationGroup rotationGroup,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    try {
      // デフォルトは過去1年から未来1年分をカレンダーで表示
      final now = DateTime.now();
      final defaultFromDate =
          fromDate ?? DateTime(now.year - 1, now.month, now.day);
      final defaultToDate =
          toDate ?? DateTime(now.year + 1, now.month, now.day);

      // currentRotationIndexを0にリセット
      final resetRotationGroup = rotationGroup.copyWith(
        currentRotationIndex: 0,
      );

      // 通知日を計算
      final rotationCalculationResult = _calculateSchedule(
        rotationGroup: resetRotationGroup,
        fromDate: defaultFromDate,
        toDate: defaultToDate,
      );
      if (rotationCalculationResult.isFailure) {
        return Results.failure(rotationCalculationResult.failureOrNull!);
      }

      final notificationSettings =
          rotationCalculationResult.valueOrNull!.notificationSettings;

      // 期間内の各日付に対してCalendarDayを作成
      final dayInfoMap = <String, CalendarDay>{};
      for (
        var checkDate = defaultFromDate;
        checkDate.isBefore(defaultToDate.add(const Duration(days: 1)));
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        // 通知日かどうか判定
        final matchingNotificationSettings =
            notificationSettings
                .where(
                  (notification) => TimeUtils.isSameDay(
                    notification.notificationTime,
                    checkDate,
                  ),
                )
                .firstOrNull;

        final isRotationDay = matchingNotificationSettings != null;
        final memberName = matchingNotificationSettings?.memberName;

        final calendarDay = CalendarDay(
          date: checkDate,
          memberName: memberName,
          isRotationDay: isRotationDay,
        );

        final key = TimeUtils.createDateKey(checkDate);
        dayInfoMap[key] = calendarDay;
      }
      return Results.success(dayInfoMap);
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダーの作成に失敗しました: $error'));
    }
  }

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  @override
  Result<RotationCalculationResult> planUpcomingNotifications({
    required RotationGroup rotationGroup,
    int futureDays = 30,
  }) {
    try {
      final currentTime = DateTime.now().toLocal();
      final fromDate = currentTime;
      final toDate = currentTime.add(Duration(days: futureDays));

      final rotationCalculationResult = _calculateSchedule(
        rotationGroup: rotationGroup,
        fromDate: fromDate,
        toDate: toDate,
      );
      if (rotationCalculationResult.isFailure) {
        return Results.failure(rotationCalculationResult.failureOrNull!);
      }
      return Results.success(rotationCalculationResult.valueOrNull!);
    } catch (error) {
      return Results.failure(NotificationFailure('通知予定の作成に失敗しました: $error'));
    }
  }

  /// 共通のスケジュール計算メソッド
  Result<RotationCalculationResult> _calculateSchedule({
    required RotationGroup rotationGroup,
    required DateTime fromDate,
    required DateTime toDate,
  }) {
    try {
      final notifications = <NotificationSetting>[];
      var currentIndex = rotationGroup.currentRotationIndex;

      // 指定期間をループして通知情報を作成
      for (
        var checkDate = fromDate;
        checkDate.isBefore(toDate.add(const Duration(days: 1)));
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        final checkDay = Weekday.fromDateTime(checkDate);

        // ローテーション日に含まれる場合
        if (rotationGroup.rotationDays.contains(checkDay)) {
          final memberIndex =
              currentIndex % rotationGroup.rotationMembers.length;
          final memberName = rotationGroup.rotationMembers[memberIndex];
          final notificationId = _generateNotificationId(
            rotationGroup.rotationGroupId!,
            checkDate,
          );
          final notificationTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            rotationGroup.notificationTime.hour,
            rotationGroup.notificationTime.minute,
          );

          final notificationSetting = NotificationSetting(
            notificationId: notificationId,
            rotationGroupId: rotationGroup.rotationGroupId!,
            ownerUserId: rotationGroup.ownerUserId,
            rotationName: rotationGroup.rotationName,
            notificationTime: notificationTime,
            memberName: memberName,
            rotationStartDate: rotationGroup.rotationStartDate,
          );

          notifications.add(notificationSetting);
          currentIndex++;
        }
      }

      return Results.success(
        RotationCalculationResult(
          notificationSettings: notifications,
          newCurrentRotationIndex: currentIndex,
        ),
      );
    } catch (error) {
      return Results.failure(NotificationFailure('スケジュール計算に失敗しました: $error'));
    }
  }

  /// 通知IDを生成 ※日付ベース
  int _generateNotificationId(String rotationGroupId, DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }
}
