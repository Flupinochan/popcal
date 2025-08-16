import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';

abstract class DeadlineCalculationService {
  Result<List<NotificationEntry>> calculationDeadlineSchedule();
}
