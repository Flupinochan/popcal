import 'package:flutter/material.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/notifications/domain/entities/notification_plan.dart';

/// 2. 計算ロジックDomain Service
abstract class RotationCalculationService {
  /// 1. 次回の通知予定日を計算
  /// [rotationDays] ローテーション曜日
  /// [notificationTime] ローテーション通知時刻
  /// [fromDate] 判定開始日 ローテーション作成日or更新日 ※カレンダー表示では作成日、通知設定では更新日
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime fromDate,
  });

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  /// [rotationGroup]
  /// [futureDays] デフォルトは今日から30日分
  Result<NotificationPlan> planUpcomingNotifications({
    required RotationGroup rotationGroup,
    int futureDays = 30,
  });

  bool isValidNotificationDate({
    required DateTime checkDate,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime createdAt,
  });

  /// ※アプリ更新時に直近30日分のスケジュールを再計算するロジックはuseCase層で実装
}
