import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';

/// 30日分の通知設定作成結果
class NotificationSchedule {
  final List<NotificationEntry> notificationEntry;
  // 通知作成分だけ増加 ※ローテーション処理に必須のため返却
  final RotationIndex newCurrentRotationIndex;

  const NotificationSchedule({
    required this.notificationEntry,
    required this.newCurrentRotationIndex,
  });

  bool get hasNotifications => notificationEntry.isNotEmpty;
  int get notificationCount => notificationEntry.length;
}
