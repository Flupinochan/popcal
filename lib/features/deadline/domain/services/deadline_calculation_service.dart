import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

abstract class DeadlineCalculationService {
  Result<List<NotificationSetting>> calculationDeadlineSchedule({
    required Deadline deadline,
  });
}
