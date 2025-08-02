import 'package:flutter/material.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_day.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

/// 2. 計算ロジックDomain Service
abstract class ScheduleCalculationService {
  /// Calendar表示用スケジュールを生成 ※1年分
  /// ※1. 実際の通知設定は30日分だが、過去1年から未来1年まで表示
  /// ※2. 作成日以降のみ表示、過去の表示は通知したことのある作成日以降の過去のみ
  Result<Map<String, CalendarDay>> buildCalendarSchedule({
    required RotationGroup rotationGroup,
    required DateTime fromDate,
    required DateTime toDate,
  });

  /// 最初の通知予定日を計算
  /// ※作成した今日がローテーション日の場合で、すでに時刻が過ぎている場合は次週から計算
  Result<DateTime?> findNextRotationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    DateTime? fromDate,
  });

  /// 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  Result<RotationCalculationResult> planUpcomingNotifications({
    required RotationGroup rotationGroup,
    int futureDays = 30,
  });

  /// ※アプリ更新時に直近30日分のスケジュールを再計算するロジックはuseCase層で実装
}
