import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/notifications/domain/entities/rotation_notification.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

abstract class NotificationRepository {
  /// 0. 初期化
  Future<Result<void>> initializeNotification();

  /// 0-2. 通知タップからアプリを起動した場合は画面遷移
  Future<Result<void>> initializeNotificationLaunch();

  /// 1 通知スケジュールを作成
  /// ※複数の情報が必要なのでentity引数
  Future<Result<void>> createNotification(RotationNotification notification);

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

  /// 【デバッグ用】通知予定ログ出力
  Future<Result<void>> logPendingNotifications();

  /// RotationGroupから30日分の通知EntityをListで作成
  Result<RotationCalculationResult> calculateNotificationSchedule({
    required RotationGroup rotationGroup,
    int daysAhead = 30,
  });

  /// 2-2. 通知予定のスケジュールを一覧取得 (Calendar表示用)
  Future<Result<List<NotificationDetail>>> getNotificationDetails();
}
