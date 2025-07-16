import 'package:popcal/features/rotation/domain/entities/rotation_notification.dart';

/// 30日分の通知設定作成結果
class RotationCalculationResult {
  final List<RotationNotification> notifications;
  // 通知作成分だけ増加
  final int newCurrentRotationIndex;

  const RotationCalculationResult({
    required this.notifications,
    required this.newCurrentRotationIndex,
  });

  bool get hasNotifications => notifications.isNotEmpty;
  int get notificationCount => notifications.length;
}
