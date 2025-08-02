import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

/// 30日分の通知設定作成結果
class RotationCalculationResult {
  final List<NotificationSetting> notificationSettings;
  // 通知作成分だけ増加
  final int newCurrentRotationIndex;

  const RotationCalculationResult({
    required this.notificationSettings,
    required this.newCurrentRotationIndex,
  });

  bool get hasNotifications => notificationSettings.isNotEmpty;
  int get notificationCount => notificationSettings.length;
}
