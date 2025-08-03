import 'package:flutter/material.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_day.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

/// 2. 計算ロジックDomain Service
abstract class ScheduleCalculationService {
  /// 1. 次回の通知予定日を計算
  /// [rotationDays] ローテーション曜日
  /// [notificationTime] ローテーション通知時刻
  /// [fromDate] 判定開始日 ローテーション作成日or更新日 ※カレンダー表示では作成日、通知設定では更新日
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime fromDate,
  });

  /// 2. Calendar表示用スケジュールを生成 ※1年分
  /// ※1. 実際の通知設定は30日分だが、カレンダーは過去1年から未来1年まで表示
  /// ※2. 最初の通知予定日以降を表示、過去の表示は通知したことのある最初の通知予定日以降の過去のみ
  /// [rotationGroup]
  /// [toDate] デフォルトは未来1年分
  Result<Map<String, CalendarDay>> buildCalendarSchedule({
    required RotationGroup rotationGroup,
    DateTime? toDate,
  });

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  /// [rotationGroup]
  /// [futureDays] デフォルトは今日から30日分
  Result<RotationCalculationResult> planUpcomingNotifications({
    required RotationGroup rotationGroup,
    int futureDays = 30,
  });

  /// ※アプリ更新時に直近30日分のスケジュールを再計算するロジックはuseCase層で実装
}
