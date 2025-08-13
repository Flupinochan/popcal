import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/entities/skip_event.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';

/// 2. 計算ロジックDomain Service
abstract class RotationCalculationService {
  /// 1. 次回の通知予定日を計算
  /// [rotationDays] ローテーション曜日
  /// [notificationTime] ローテーション通知時刻
  /// [rotationDateTime] 判定開始日 ※カレンダー表示では作成日、通知設定では更新日
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  });

  /// ローテーション日の種別を判定
  ScheduleDayType getScheduleDayType({
    required DateKey checkDate,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  });

  /// [checkDate] がローテーション曜日か判定
  bool isValidNotificationDate({
    required DateKey checkDate,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  });

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  /// [rotation]
  /// [futureDays] デフォルトは今日から30日分
  Result<NotificationSchedule> planUpcomingNotifications({
    required Rotation rotation,
    int futureDays = 30,
  });

  /// ※アプリ更新時に直近30日分のスケジュールを再計算するロジックはuseCase層で実装
}
