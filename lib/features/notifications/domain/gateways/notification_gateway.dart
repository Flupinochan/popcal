import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

/// 1. CRUD操作
abstract class NotificationGateway {
  /// 1 通知スケジュールを作成
  Future<Result<void>> createNotification(NotificationEntry notificationEntry);

  /// 4-3. 全通知を削除
  Future<Result<void>> deleteAllNotifications();

  /// 3. 通知を更新
  /// ※local notificationにupdateは存在しないため UseCase層で delete + create で実装

  /// 4-1. 特定の通知を削除
  Future<Result<void>> deleteNotification(NotificationId notificationId);

  /// 4-2 特定のrotationIdの通知を削除
  Future<Result<void>> deleteNotificationsByRotationId(RotationId rotationId);

  /// 2. 通知予定のスケジュールを一覧取得
  Future<Result<List<NotificationId>>> getNotifications();

  /// 0-1. 初期化
  /// 通知アイコン設定
  /// アプリ起動中に通知をタップした際の動作を設定
  Future<Result<void>> initializeNotification();

  /// 0-2. アプリが起動していない場合に、通知タップからアプリを起動した場合
  Future<Result<void>> initializeNotificationLaunch();
}
