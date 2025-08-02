import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

/// 30日分の通知設定作成結果
class RotationCalculationResult {
  final List<NotificationSetting> notifications;
  // 通知作成分だけ増加
  final int newCurrentRotationIndex;

  const RotationCalculationResult({
    required this.notifications,
    required this.newCurrentRotationIndex,
  });

  bool get hasNotifications => notifications.isNotEmpty;
  int get notificationCount => notifications.length;
}
