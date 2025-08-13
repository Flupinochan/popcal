import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';

/// 30日分の通知設定作成結果
class NotificationSchedule {
  const NotificationSchedule({
    required this.notificationEntries,
    required this.newCurrentRotationIndex,
  });

  final List<NotificationEntry> notificationEntries;
  // 通知作成分だけ増加 ※ローテーション処理に必須のため返却
  final RotationIndex newCurrentRotationIndex;

  bool get hasNotifications => notificationEntries.isNotEmpty;
  int get notificationCount => notificationEntries.length;
}
