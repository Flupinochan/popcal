import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_notification.dart';

class NotificationRepositoryLocal implements NotificationRepository {
  final LocalNotificationsDatasource _localNotificationsDatasource;

  NotificationRepositoryLocal(this._localNotificationsDatasource);

  /// 0. 初期化
  @override
  Future<Result<void>> initializeNotification() async {
    final result = await _localNotificationsDatasource.initializeNotification();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 0-2. 通知タップからアプリを起動した場合は画面遷移
  @override
  Future<Result<void>> initializeNotificationLaunch() async {
    final result =
        await _localNotificationsDatasource.initializeNotificationLaunch();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 1. 通知スケジュールを作成
  @override
  Future<Result<void>> createNotification(
    RotationNotification notification,
  ) async {
    final result = await _localNotificationsDatasource.createNotification(
      notification,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  /// 2. 通知予定のスケジュールを一覧取得
  @override
  Future<Result<List<int>>> getNotifications() async {
    final result = await _localNotificationsDatasource.getNotifications();
    return result.when(
      success: (notificationIds) => Results.success(notificationIds),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> updateNotification(RotationGroup rotationGroup) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }

  /// 4. 特定の通知を削除(キャンセル)
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

  /// 5. 全通知を削除(キャンセル)
  @override
  Future<Result<void>> deleteNotifications() async {
    final result = await _localNotificationsDatasource.deleteNotifications();
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }
}
