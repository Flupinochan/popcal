import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';

/// 30日分の通知設定計算結果
class NotificationSchedule {
  const NotificationSchedule({
    required this.notificationEntries,
    required this.newCurrentRotationIndex,
  });

  final List<NotificationEntry> notificationEntries;
  // 通知計算の後にローテーション情報を更新するために必要
  final RotationIndex newCurrentRotationIndex;
}
