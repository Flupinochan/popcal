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
    final defaultCurrentTime = currentTime ?? DateTime.now().toLocal();

    // 曜日指定のローテーション機能であり、遅くても未来7日後までに最初の通知日があるはず
    for (
      var checkDate = defaultCurrentTime;
      checkDate.isBefore(defaultCurrentTime.add(const Duration(days: 8)));
      checkDate = checkDate.add(const Duration(days: 1))
    ) {
      // 開始日は+0日で、今から未来+7日分をチェック
      final checkDay = Weekday.fromDateTime(checkDate);

      // ローテーション曜日の場合
      if (rotationDays.contains(checkDay)) {
        // 当日の場合は通知時刻で判定
        if (TimeUtils.isSameDay(checkDate, defaultCurrentTime)) {
          final notificationDateTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            notificationTime.hour,
            notificationTime.minute,
          );
          // 未来の日付かどうか
          if (notificationDateTime.isAfter(defaultCurrentTime)) {
            return Results.success(checkDate);
          }
        } else if (checkDate.isAfter(defaultCurrentTime)) {
          // 翌日以降はそのまま判定
          return Results.success(checkDate);
        }
      }
    }
    return Results.failure(ValidationFailure('次回ローテーション日の取得に失敗しました'));
  }

  /// 2. Calendar表示用スケジュールを生成 ※1年分
  @override
  @override
  Result<Map<String, CalendarDay>> buildCalendarSchedule({
    required RotationGroup rotationGroup,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    try {
      final now = DateTime.now();
      final defaultFromDate =
          fromDate ?? DateTime(now.year - 1, now.month, now.day);
      final defaultToDate =
          toDate ?? DateTime(now.year + 1, now.month, now.day);

      // 1. 最初の通知予定日を計算
      final firstNotificationDateResult = findNextRotationDate(
        rotationDays: rotationGroup.rotationDays,
        notificationTime: rotationGroup.notificationTime,
        currentTime: DateTime.now().toLocal(),
      );

      if (firstNotificationDateResult.isFailure) {
        return Results.failure(firstNotificationDateResult.failureOrNull!);
      }

      final firstNotificationDate = firstNotificationDateResult.valueOrNull!;

      // 2. カレンダー表示用の計算（専用メソッド）
      final calendarResult = _buildCalendarDays(
        rotationGroup: rotationGroup,
        fromDate: defaultFromDate,
        toDate: defaultToDate,
        firstNotificationDate: firstNotificationDate,
      );

      return calendarResult;
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダーの作成に失敗しました: $error'));
    }
  }

  /// カレンダー表示専用の計算メソッド
  Result<Map<String, CalendarDay>> _buildCalendarDays({
    required RotationGroup rotationGroup,
    required DateTime fromDate,
    required DateTime toDate,
    required DateTime firstNotificationDate,
  }) {
    try {
      final dayInfoMap = <String, CalendarDay>{};
      var currentIndex = 0;

      // 期間内の各日付をループ（過去1年〜未来1年）
      for (
        var checkDate = fromDate;
        checkDate.isBefore(toDate.add(const Duration(days: 1)));
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        final checkDay = Weekday.fromDateTime(checkDate);

        // ローテーション日かつ最初の通知予定日以降かどうか判定
        final isRotationDay = rotationGroup.rotationDays.contains(checkDay);
        final isAfterFirstNotification =
            checkDate.isAfter(firstNotificationDate) ||
            TimeUtils.isSameDay(checkDate, firstNotificationDate);

        // 通知日として表示するかどうか
        final isNotificationDay = isRotationDay && isAfterFirstNotification;

        String? memberName;
        if (isNotificationDay) {
          // 担当者を計算
          final memberIndex =
              currentIndex % rotationGroup.rotationMembers.length;
          memberName = rotationGroup.rotationMembers[memberIndex];
          currentIndex++;
        }

        final calendarDay = CalendarDay(
          date: checkDate,
          memberName: memberName,
          isRotationDay: isNotificationDay,
        );

        final key = TimeUtils.createDateKey(checkDate);
        dayInfoMap[key] = calendarDay;
      }

      return Results.success(dayInfoMap);
    } catch (error) {
      return Results.failure(CalendarFailure('カレンダー日付の計算に失敗しました: $error'));
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

        // ローテーション日 かつ 最初の通知予定日以降の場合 ※最初の通知予定日を含む
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
