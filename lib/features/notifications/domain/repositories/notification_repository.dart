import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

/// 1. CRUD操作
abstract class NotificationRepository {
  /// 0-1. 初期化 ※とりあえず必要
  Future<Result<void>> initializeNotification();

  /// 0-2. 通知タップからアプリを起動した場合の画面遷移
  Future<Result<void>> initializeNotificationLaunch();

  /// 1 通知スケジュールを作成
  Future<Result<void>> createNotification(
    NotificationSetting notificationSetting,
  );

  /// 2. 通知予定のスケジュールを一覧取得 ※デフォルトは30日分
  /// rotationGroupIdのListを取得
  Future<Result<List<int>>> getNotifications();

  /// 3. 通知を更新
  /// ※local notificationにupdateは存在しないため delete + create で実装する

  /// 4-1. 特定の通知を削除
  Future<Result<void>> deleteNotification(int notificationId);

  /// 4-2 特定のrotationGroupIdの通知を削除
  Future<Result<void>> deleteNotificationsByRotationGroupId(
    String rotationGroupId,
  );

  /// 4-3. 全通知を削除
  Future<Result<void>> deleteAllNotifications();

  /// 【デバッグ用】通知予定ログ出力
  Future<Result<void>> logPendingNotifications();
}
