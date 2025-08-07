import 'package:flutter/material.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';

class RotationCalculationServiceImpl implements RotationCalculationService {
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
      if (isValidNotificationDate(
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

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  @override
  Result<NotificationSchedule> planUpcomingNotifications({
    required Rotation rotation,
    int futureDays = 30,
  }) {
    try {
      // 現在時刻をベース
      final currentTime = DateTime.now().toLocal();
      final toDate = currentTime.add(Duration(days: futureDays));

      final notifications = <NotificationEntry>[];
      var currentIndex = rotation.currentRotationIndex;

      // 指定期間をループして通知情報を作成
      for (
        var checkDate = currentTime;
        checkDate.isBefore(toDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        if (isValidNotificationDate(
          checkDate: checkDate,
          rotationDays: rotation.rotationDays,
          notificationTime: rotation.notificationTime,
          createdAt: currentTime,
        )) {
          final memberIndex = currentIndex % rotation.rotationMembers.length;
          final memberName = rotation.rotationMembers[memberIndex];
          final notificationId = _generateNotificationId(
            rotation.rotationId!,
            checkDate,
          );
          final scheduledDateTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            rotation.notificationTime.hour,
            rotation.notificationTime.minute,
          );

          final notificationSetting = NotificationEntry(
            notificationId: notificationId,
            rotationId: rotation.rotationId!,
            userId: rotation.userId,
            rotationName: rotation.rotationName,
            notificationTime: scheduledDateTime,
            memberName: memberName,
            rotationStartDate: rotation.createdAt,
          );

          notifications.add(notificationSetting);
          currentIndex++;
        }
      }

      return Results.success(
        NotificationSchedule(
          notificationEntry: notifications,
          newCurrentRotationIndex: currentIndex,
        ),
      );
    } catch (error) {
      return Results.failure(NotificationFailure('通知予定の作成に失敗しました: $error'));
    }
  }

  /// ローテーション日判定
  @override
  bool isValidNotificationDate({
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

  /// 通知IDを生成 ※日付ベース
  int _generateNotificationId(String rotationId, DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }
}
