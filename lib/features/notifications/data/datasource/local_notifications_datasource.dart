import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
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
        // 通知をタップした際の動作
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload;
          if (payload != null) {
            // 画面遷移
            _router!.push(Routes.rotationUpdatePath(payload));
          }
        },
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

  /// 1. 通知スケジュールを作成
  Future<Result<void>> createNotification(RotationGroup rotationGroup) async {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(NotificationFailure('rotationGrpupIdがnullです'));
      }
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        rotationGroup.notificationId,
        rotationGroup.rotationName,
        rotationGroup.rotationMembers.join(', '),
        tz.TZDateTime.from(rotationGroup.notificationTime, tz.local),
        NotificationDetails(
          // channel情報はOS通知設定に表示され、それをもとにユーザがON/OFF可能
          android: AndroidNotificationDetails(
            rotationGroup.rotationGroupId!,
            rotationGroup.rotationName,
            channelDescription: '${rotationGroup.rotationName}の通知',
            priority: Priority.high,
            importance: Importance.high,
            showWhen: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: rotationGroup.rotationGroupId, // タップ時に渡すデータ
      );
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の作成に失敗しました: $error'));
    }
  }

  /// 2. 通知予定のスケジュールを一覧取得
  Future<Result<List<String>>> getNotifications() async {
    try {
      final List<PendingNotificationRequest> pendingNotificationRequests =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
      // rotationGroupIdのListを作成
      final rotationGroupIds =
          pendingNotificationRequests
              .map((notification) => notification.payload)
              .where((payload) => payload != null)
              .cast<String>()
              .toList();
      return Results.success(rotationGroupIds);
    } catch (error) {
      return Results.failure(NetworkFailure('通知の取得に失敗しました: $error'));
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
}
