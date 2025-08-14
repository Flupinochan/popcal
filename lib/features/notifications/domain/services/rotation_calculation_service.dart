import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

/// 2. 計算ロジックDomain Service
abstract class RotationCalculationService {
  Result<NotificationSchedule> getNotificationEntry({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });

  Result<Map<DateKey, ScheduleDay>> getScheduleMap({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });
}
