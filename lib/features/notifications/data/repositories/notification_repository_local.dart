import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

class NotificationRepositoryLocal implements NotificationRepository {
  final LocalNotificationsDatasource _localNotificationsDatasource;

  NotificationRepositoryLocal(this._localNotificationsDatasource);

  /// 0-1. 初期化 ※とりあえず必要
  @override
  Future<Result<void>> initializeNotification() async {
    final result = await _localNotificationsDatasource.initializeNotification();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 0-2. 通知タップからアプリを起動した場合の画面遷移
  @override
  Future<Result<void>> initializeNotificationLaunch() async {
    final result =
        await _localNotificationsDatasource.initializeNotificationLaunch();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 1 通知スケジュールを作成
  @override
  Future<Result<void>> createNotification(
    NotificationSetting notificationSetting,
  ) async {
    final result = await _localNotificationsDatasource.createNotification(
      notificationSetting,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 2. 通知予定のスケジュールを一覧取得 ※デフォルトは30日分
  @override
  Future<Result<List<int>>> getNotifications() async {
    final result = await _localNotificationsDatasource.getNotifications();
    return result.when(
      success: (notificationIds) => Results.success(notificationIds),
      failure: (error) => Results.failure(error),
    );
  }

  /// 4-1. 特定の通知を削除
  @override
  Future<Result<void>> deleteNotification(int notificationId) async {
    final result = await _localNotificationsDatasource.deleteNotification(
      notificationId,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 4-2 特定のrotationGroupIdの通知を削除
  @override
  Future<Result<void>> deleteNotificationsByRotationGroupId(
    String rotationGroupId,
  ) async {
    final result = await _localNotificationsDatasource
        .deleteNotificationsByRotationGroupId(rotationGroupId);
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 4-3. 全通知を削除
  @override
  Future<Result<void>> deleteAllNotifications() async {
    final result = await _localNotificationsDatasource.deleteNotifications();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 【デバッグ用】通知予定ログ出力
  @override
  Future<Result<void>> logPendingNotifications() async {
    final result =
        await _localNotificationsDatasource.logPendingNotifications();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }
}
