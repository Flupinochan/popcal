import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

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

  /// 1. 通知スケジュールを作成
  @override
  Future<Result<void>> createNotification(RotationGroup rotationGroup) async {
    final result = await _localNotificationsDatasource.createNotification(
      rotationGroup,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> deleteNotification(String rotationGroupId) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteNotifications(String userId) {
    // TODO: implement deleteNotifications
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> getNotifications(String userId) {
    // TODO: implement getNotifications
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateNotification(RotationGroup rotationGroup) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }
}
