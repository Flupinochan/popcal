import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

class NotificationRepositoryLocal implements NotificationRepository {
  @override
  Future<Result<void>> createNotification(RotationGroup rotationGroup) {
    // TODO: implement createNotification
    throw UnimplementedError();
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
