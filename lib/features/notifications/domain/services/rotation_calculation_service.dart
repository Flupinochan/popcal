import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

/// 計算ロジックDomain Service
/// Rotation Entityのみを利用するが、処理内容が大きいため、サービスとして定義
abstract class RotationCalculationService {
  /// 通知設定データ取得用
  Result<NotificationSchedule> calculationNotificationSchedule({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });

  /// カレンダー表示データ取得用
  Result<Map<DateKey, ScheduleDay>> calculationScheduleMap({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });
}
