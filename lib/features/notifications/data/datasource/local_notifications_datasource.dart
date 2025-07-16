import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_notification.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsDatasource {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GoRouter _router;

  LocalNotificationsDatasource(this._router);

  /// 0. 初期化
  /// 通知アイコンや通知をタップした際の動作を設定
  Future<Result<void>> initializeNotification() async {
    try {
      const AndroidInitializationSettings android =
          AndroidInitializationSettings(
            // 'app_icon',
            '@mipmap/ic_launcher',
          );
      const InitializationSettings settings = InitializationSettings(
        android: android,
      );

      // 初期化
      _flutterLocalNotificationsPlugin.initialize(
        settings,
        // 1.アプリ起動中に通知をタップした際の動作
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload;
          if (payload != null) {
            _router!.push(Routes.rotationUpdatePath(payload));
          }
        },
        // 2.アプリが起動していない場合に通知をタップした際の動作
        // ※通知をタップしたらデフォルトでアプリが起動するため、アプリ起動時の処理で遷移するため不要
        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('初期化に失敗しました: $error'));
    }
  }

  /// 通知許可を求める権限確認ポップアップを表示
  /// Returns: 通知が可能な場合はtrueを返却
  Future<Result<bool>> _requestNotificationPermission() async {
    try {
      final androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidImplementation != null) {
        final bool? granted =
            await androidImplementation.requestNotificationsPermission();
        return Results.success(granted ?? false);
      }
      // Android以外のプラットフォームでは常にfalse
      return Results.success(false);
    } catch (error) {
      return Results.failure(NotificationFailure('通知権限の許可に失敗しました: $error'));
    }
  }

  /// 通知権限状態の確認
  /// Returns: 通知が可能な場合はtrueを返却
  Future<Result<bool>> _isAndroidPermissionGranted() async {
    try {
      final bool granted =
          await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          false;
      return Results.success(granted);
    } catch (error) {
      return Results.failure(NotificationFailure('通知権限状態の確認に失敗しました: $error'));
    }
  }

  /// 0-2. 通知タップからアプリを起動した場合は画面遷移
  Future<Result<void>> initializeNotificationLaunch() async {
    try {
      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      // 通知タップからアプリが起動したかどうか判定
      if (notificationAppLaunchDetails != null &&
          notificationAppLaunchDetails.didNotificationLaunchApp) {
        final payload =
            notificationAppLaunchDetails.notificationResponse?.payload;
        if (payload != null) {
          _router!.push(Routes.rotationUpdatePath(payload));
        }
      }
      return Results.success(null);
    } catch (error) {
      return Results.failure(
        NotificationFailure('通知タップから起動の確認に失敗しました: $error'),
      );
    }
  }

  /// 1. 通知スケジュールを作成
  Future<Result<void>> createNotification(
    RotationNotification notification,
  ) async {
    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notification.notificationId,
        notification.title,
        notification.message,
        tz.TZDateTime.from(notification.notificationTime, tz.local),
        NotificationDetails(
          // channel情報はOS通知設定に表示され、それをもとにユーザがON/OFF可能
          android: AndroidNotificationDetails(
            notification.rotationGroupId,
            notification.rotationName,
            channelDescription: '${notification.rotationName}の通知',
            priority: Priority.high,
            importance: Importance.high,
            showWhen: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: notification.rotationGroupId, // タップ時に渡すデータ
      );
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の作成に失敗しました: $error'));
    }
  }

  /// 2. 通知予定のスケジュールを一覧取得
  Future<Result<List<int>>> getNotifications() async {
    try {
      final List<PendingNotificationRequest> pendingNotificationRequests =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
      final notificationIds =
          pendingNotificationRequests
              .map((notification) => notification.id)
              .toList();
      return Results.success(notificationIds);
    } catch (error) {
      return Results.failure(NetworkFailure('通知の取得に失敗しました: $error'));
    }
  }

  /// 4. 特定の通知を削除(キャンセル)
  Future<Result<void>> deleteNotification(int notificationId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(notificationId);
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 5. 全通知を削除(キャンセル)
  Future<Result<void>> deleteNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 【デバッグ用】通知予定ログ出力
  Future<Result<void>> logPendingNotifications() async {
    try {
      final List<PendingNotificationRequest> pendingNotifications =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

      print('=== 設定済み通知一覧 (${pendingNotifications.length}件) ===');

      for (final notification in pendingNotifications) {
        String dateTime = '日時不明';

        if (notification.payload != null) {
          try {
            final payload = jsonDecode(notification.payload!);
            final notificationTime = DateTime.parse(
              payload['notificationTime'] as String,
            ); // 🔥 as String でキャスト
            dateTime =
                '${notificationTime.month}/${notificationTime.day} ${notificationTime.hour.toString().padLeft(2, '0')}:${notificationTime.minute.toString().padLeft(2, '0')}';
          } catch (e) {
            // 古いpayload形式の場合は日時不明のまま
          }
        }

        print('$dateTime | ${notification.title} | ${notification.body}');
      }

      if (pendingNotifications.isEmpty) {
        print('設定済み通知はありません');
      }

      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知一覧の取得に失敗しました: $error'));
    }
  }
}
