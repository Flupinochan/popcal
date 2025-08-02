import 'package:flutter/material.dart';
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

  /// 特定のrotationGroupIdの通知を削除(キャンセル)
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

  /// RotationGroupから30日分の通知EntityをListで作成（未来分のみ）
  @override
  Result<RotationCalculationResult> calculateNotificationSchedule({
    required RotationGroup rotationGroup,
    int daysAhead = 30,
  }) {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未初期化です'));
      }

      // 常に今日から計算開始
      final now = DateTime.now().toLocal();
      final startDate = now; // 今日から開始
      final endDate = now.add(Duration(days: daysAhead));

      print('=== 通知スケジュール計算開始 ===');
      print('ローテーション名: ${rotationGroup.rotationName}');
      print('計算期間: ${startDate} ～ ${endDate}');
      print('現在時刻: $now');
      print('元のcurrentRotationIndex: ${rotationGroup.currentRotationIndex}');
      print('メンバー: ${rotationGroup.rotationMembers}');
      print(
        '対象曜日: ${rotationGroup.rotationDays.map((w) => w.displayName).join(', ')}',
      );
      print(
        '通知時刻: ${rotationGroup.notificationTime.hour}:${rotationGroup.notificationTime.minute}',
      );

      final result = _generateNotifications(
        rotationGroup: rotationGroup,
        startDate: startDate,
        endDate: endDate,
        currentTime: now,
      );

      print('生成された通知数: ${result.notifications.length}');
      print('最終currentRotationIndex: ${result.newCurrentRotationIndex}');
      print('=== 通知スケジュール計算終了 ===');

      return Results.success(result);
    } catch (e) {
      return Results.failure(NetworkFailure('通知の作成に失敗しました: $e'));
    }
  }

  /// 最初の通知予定日を取得
  Result<DateTime?> getFirstNotificationDate({
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    DateTime? fromDate,
  }) {
    try {
      final now = fromDate ?? DateTime.now().toLocal();

      // 最大30日先まで検索
      for (int i = 0; i < 30; i++) {
        final checkDate = now.add(Duration(days: i));
        final weekday = Weekday.fromDateTime(checkDate);

        if (rotationDays.contains(weekday)) {
          final notificationDateTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            notificationTime.hour,
            notificationTime.minute,
          );

          // 未来の通知時刻の場合
          if (notificationDateTime.isAfter(now)) {
            print('最初の通知予定日: $notificationDateTime');
            return Results.success(notificationDateTime);
          }
        }
      }

      print('警告: 最初の通知予定日が見つかりませんでした');
      return Results.success(null);
    } catch (e) {
      return Results.failure(ValidationFailure('最初の通知予定日の取得に失敗しました: $e'));
    }
  }

  /// RotationGroupから1年分の通知情報(Calendar表示用)を作成
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

      print('=== カレンダー詳細計算開始 ===');
      print('期間: ${startDate} ～ ${endDate}');

      // カレンダー表示用：currentRotationIndexを0にしたコピーを作成
      final rotationGroupForCalendar = rotationGroup.copyWith(
        currentRotationIndex: 0,
      );

      // カレンダー表示はrotationStartDate（最初の通知予定日）から開始
      // 時刻チェックなしで全期間を計算
      final result = _generateNotifications(
        rotationGroup: rotationGroupForCalendar,
        startDate: startDate,
        endDate: endDate,
        currentTime: rotationGroup.rotationStartDate,
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

      print('カレンダー詳細生成数: ${details.length}');
      print('=== カレンダー詳細計算終了 ===');

      return Results.success(details);
    } catch (e) {
      return Results.failure(NetworkFailure('カレンダー詳細の計算に失敗しました: $e'));
    }
  }

  /// 通知生成（統一メソッド）
  RotationCalculationResult _generateNotifications({
    required RotationGroup rotationGroup,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? currentTime, // nullの場合は時刻チェックなし
  }) {
    final notifications = <RotationNotification>[];
    var currentIndex = 0; // 常に0から開始

    print('--- 通知生成詳細 ---');
    print('開始currentIndex: $currentIndex (強制的に0から開始)');
    print('時刻チェック: ${currentTime != null ? "あり ($currentTime)" : "なし"}');

    // 指定期間をループ
    for (
      var date = startDate; // 開始日
      date.isBefore(endDate.add(const Duration(days: 1))); // 終了日
      date = date.add(const Duration(days: 1)) // +1日
    ) {
      // 曜日を取得
      final weekday = Weekday.fromDateTime(date);

      // 曜日がローテーション曜日か判定
      if (rotationGroup.rotationDays.contains(weekday)) {
        final notificationTime = DateTime(
          date.year,
          date.month,
          date.day,
          rotationGroup.notificationTime.hour,
          rotationGroup.notificationTime.minute,
        );

        // 時刻チェック（currentTimeがnullの場合はスキップ）
        bool shouldInclude = true;
        if (currentTime != null) {
          shouldInclude = notificationTime.isAfter(currentTime);
        }

        if (shouldInclude) {
          final memberIndex =
              currentIndex % rotationGroup.rotationMembers.length;
          final memberName = rotationGroup.rotationMembers[memberIndex];

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
            rotationStartDate: DateTime.now().toLocal(),
          );

          notifications.add(notification);
          print(
            '通知追加: ${date.month}/${date.day}(${weekday.displayName}) - $memberName (currentIndex: $currentIndex -> memberIndex: $memberIndex)',
          );
          currentIndex++;
        } else {
          print(
            '時刻が過去のためスキップ: ${date.month}/${date.day}(${weekday.displayName}) - 時刻: $notificationTime',
          );
        }
      }
    }

    print('最終currentIndex: $currentIndex');
    print('生成された通知数: ${notifications.length}');
    print('--- 通知生成詳細終了 ---');

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
