import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/notifications/domain/entities/rotation_notification.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

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

  /// 2-2. 通知予定のスケジュールを一覧取得 (Calendar表示用)
  @override
  Future<Result<List<NotificationDetail>>> getNotificationDetails() async {
    final result = await _localNotificationsDatasource.getNotificationDetails();
    return result.when(
      success: (details) => Results.success(details),
      failure: (error) => Results.failure(error),
    );
  }

  /// RotationGroupから30日分の通知EntityをListで作成
  @override
  Result<RotationCalculationResult> calculateNotificationSchedule({
    required RotationGroup rotationGroup,
    int daysAhead = 30,
  }) {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未初期化です'));
      }

      final now = DateTime.now().toLocal();
      final endDate = now.add(Duration(days: daysAhead));

      final result = _generateNotifications(
        rotationGroup: rotationGroup,
        startDate: now,
        endDate: endDate,
      );

      return Results.success(result);
    } catch (e) {
      return Results.failure(NetworkFailure('通知の作成に失敗しました: $e'));
    }
  }

  /// RotationGroupから1年分の通知情報(Calendar表示用)を作成
  /// startDate(作成日)からcurrentRotationIndex: 0にして計算
  @override
  Result<List<NotificationDetail>> calculateCalendarDetails({
    required RotationGroup rotationGroup,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未初期化です'));
      }

      // カレンダー表示用：currentRotationIndexを0にしたコピーを作成
      final rotationGroupForCalendar = rotationGroup.copyWith(
        currentRotationIndex: 0,
      );

      // 既存の_generateNotificationsメソッドを流用
      final result = _generateNotifications(
        rotationGroup: rotationGroupForCalendar,
        startDate: startDate,
        endDate: endDate,
      );

      // RotationNotification → NotificationDetail に変換
      final details =
          result.notifications.map((notification) {
            return NotificationDetail(
              notificationId: notification.notificationId,
              date: notification.notificationDate,
              memberName: notification.memberName,
              title: notification.title,
              body: notification.message,
            );
          }).toList();

      return Results.success(details);
    } catch (e) {
      return Results.failure(NetworkFailure('カレンダー詳細の計算に失敗しました: $e'));
    }
  }

  RotationCalculationResult _generateNotifications({
    required RotationGroup rotationGroup,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final notifications = <RotationNotification>[];
    var currentIndex = rotationGroup.currentRotationIndex;

    // 30日分をループ
    for (
      var date = startDate; // 開始日
      date.isBefore(endDate.add(const Duration(days: 1))); // 終了日
      date = date.add(const Duration(days: 1)) // +1日
    ) {
      // 曜日を取得
      final weekday = Weekday.fromDateTime(date);

      // 曜日がローテーション曜日か判定
      if (rotationGroup.rotationDays.contains(weekday)) {
        final memberIndex = currentIndex % rotationGroup.rotationMembers.length;
        final memberName = rotationGroup.rotationMembers[memberIndex];

        final notificationTime = DateTime(
          date.year,
          date.month,
          date.day,
          rotationGroup.notificationTime.hour,
          rotationGroup.notificationTime.minute,
        );

        final notificationId = _generateNotificationId(
          rotationGroup.rotationGroupId!,
          date,
        );

        final notification = RotationNotification(
          notificationId: notificationId,
          rotationGroupId: rotationGroup.rotationGroupId!,
          ownerUserId: rotationGroup.ownerUserId,
          rotationName: rotationGroup.rotationName,
          notificationTime: notificationTime,
          memberName: memberName,
          createdAt: DateTime.now().toLocal(),
        );

        notifications.add(notification);
        currentIndex++;
      }
    }

    return RotationCalculationResult(
      notifications: notifications,
      newCurrentRotationIndex: currentIndex,
    );
  }

  int _generateNotificationId(String rotationGroupId, DateTime date) {
    final dateInt = date.year * 10000 + date.month * 100 + date.day;
    return dateInt;
  }
}
