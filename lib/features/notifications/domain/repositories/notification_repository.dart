import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

abstract class NotificationRepository {
  /// 0. 初期化
  Future<Result<void>> initializeNotification();

  /// 1. 通知スケジュールを作成
  /// ※複数の情報が必要なのでentity引数
  Future<Result<void>> createNotification(RotationGroup rotationGroup);

  /// 2. 通知予定のスケジュールを一覧取得
  /// rotationGroupIdのListを取得
  Future<Result<List<int>>> getNotifications();

  /// 3. 通知を更新
  /// ※複数の情報が必要なのでentity引数
  /// ※local notificationにupdateは存在しないためdelete + createで実装する
  Future<Result<void>> updateNotification(RotationGroup rotationGroup);

  /// 4. 特定の通知を削除(キャンセル)
  /// ※rotationGroupIdのみで十分
  Future<Result<void>> deleteNotification(int notificationId);

  /// 5. 全通知を削除(キャンセル)
  Future<Result<void>> deleteNotifications();
}

// 使用予定メソッド
// // 2. pendingNotificationRequests - 一覧取得
// final pending = await _plugin.pendingNotificationRequests();

// // 3. cancel - 特定通知キャンセル
// await _plugin.cancel(notificationId);

// // 4. cancelAll - 全通知キャンセル
// await _plugin.cancelAll();

// // 5. initialize - 初期化
// await _plugin.initialize(settings, onDidReceiveNotificationResponse: callback);
