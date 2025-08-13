import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';

class DayCalculationData {
  const DayCalculationData({
    required this.notificationDateTime,
    required this.memberIndex,
    required this.dayType,
  });

  // 通知日時
  final NotificationDateTime notificationDateTime;
  // 担当者 ※ローテーション日でない場合はnull
  final int? memberIndex;
  // タイプ
  final DayType dayType;
}
