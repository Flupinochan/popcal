import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

abstract class NotificationRepository {
  /// 通知スケジュールを作成
  /// ※複数の情報が必要なのでentity引数
  Future<Result<void>> scheduleNotification(RotationGroup rotationGroup);

  /// 通知予定のスケジュールを一覧取得
  /// ※userIdのみで十分
  Future<Result<List<Map<String, dynamic>>>> getScheduledNotifications(
    String userId,
  );

  /// 通知を更新
  /// ※複数の情報が必要なのでentity引数
  Future<Result<void>> updateNotification(RotationGroup rotationGroup);

  /// 通知を削除(キャンセル)
  /// ※rotationGroupIdのみで十分
  Future<Result<void>> deleteNotification(String rotationGroupId);

  /// 指定したユーザの全通知を削除(キャンセル)
  /// ※userIdのみで十分
  Future<Result<void>> deleteAllNotifications(String userId);
}
