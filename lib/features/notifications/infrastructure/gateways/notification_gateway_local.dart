import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/infrastructure/dto/notification_entry_local_response.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationGatewayLocal {
  NotificationGatewayLocal(
    this._router,
    this._flutterLocalNotificationsPlugin,
    this._timeUtils,
  );
  final GoRouter _router;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final TimeUtils _timeUtils;

  /// 1. 通知スケジュールを作成
  Future<Result<void>> createNotification(
    NotificationEntryLocalResponse notificationSettingDto,
  ) async {
    try {
      final now = _timeUtils.now();
      if (notificationSettingDto.notificationDate.isBeforeDateTime(now)) {
        return Results.failure(
          NotificationFailure(
            '警告: 過去の通知作成が要求されました - ${notificationSettingDto.notificationDate} - ${notificationSettingDto.memberName}',
          ),
        );
      }

      final payloadJson = notificationSettingDto.toJsonString();

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationSettingDto.notificationId.value,
        notificationSettingDto.title,
        notificationSettingDto.content,
        tz.TZDateTime.from(
          notificationSettingDto.notificationDate.value,
          tz.local,
        ),
        NotificationDetails(
          // channel情報はOS通知設定に表示され、それをもとにユーザがON/OFF可能
          android: AndroidNotificationDetails(
            notificationSettingDto.rotationId.value,
            notificationSettingDto.title,
            channelDescription: notificationSettingDto.description,
            priority: Priority.high,
            importance: Importance.high,
            icon: 'notification_small_icon',
            largeIcon: const DrawableResourceAndroidBitmap(
              'notification_large_icon',
            ),
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payloadJson, // タップ時に渡すデータ
      );
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知の作成に失敗しました: $error'));
    }
  }

  /// 4-1. 特定の通知を削除
  Future<Result<void>> deleteNotification(int notificationId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(notificationId);
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 4-3. 全通知を削除
  Future<Result<void>> deleteNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 4-2 特定のrotationIdの通知を削除
  Future<Result<void>> deleteNotificationsByRotationId(
    String rotationId,
  ) async {
    try {
      final pendingNotifications =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

      String? errorMessage;
      for (final notification in pendingNotifications) {
        if (notification.payload != null) {
          LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
            notification.payload!,
          ).when(
            success: (localNotificationSettingDto) {
              if (localNotificationSettingDto.rotationId ==
                  RotationId(rotationId)) {
                try {
                  _flutterLocalNotificationsPlugin.cancel(notification.id);
                } on Exception catch (error) {
                  errorMessage = error.toString();
                }
              }
            },
            failure: (error) => errorMessage = error.message,
          );
        }
      }
      return errorMessage != null
          ? Results.failure(NotificationFailure(errorMessage!))
          : Results.success(null);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 2. 通知予定のスケジュールを一覧取得
  Future<Result<List<int>>> getNotifications() async {
    try {
      final pendingNotificationRequests =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
      final notificationIds =
          pendingNotificationRequests
              .map((notification) => notification.id)
              .toList();
      return Results.success(notificationIds);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知の取得に失敗しました: $error'));
    }
  }

  /// 0-1. 初期化
  /// 通知アイコン設定
  /// アプリ起動中に通知をタップした際の動作を設定
  Future<Result<void>> initializeNotification() async {
    try {
      const android = AndroidInitializationSettings('notification_small_icon');
      const settings = InitializationSettings(
        android: android,
      );

      // 初期化
      await _flutterLocalNotificationsPlugin.initialize(
        settings,
        // 1.アプリ起動中に通知をタップした際の動作
        onDidReceiveNotificationResponse: (response) {
          _handleNotificationTap(response.payload);
        },
        // 2.アプリが起動していない場合に通知をタップした際の動作
        // ※通知をタップしたらデフォルトでアプリが起動するため、アプリ起動時の処理で遷移するため不要
        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      // 権限要求
      await _requestNotificationPermission();
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('初期化に失敗しました: $error'));
    }
  }

  /// 0-2. アプリが起動していない場合に、通知タップからアプリを起動した場合
  Future<Result<void>> initializeNotificationLaunch() async {
    try {
      final notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      // 通知タップからアプリが起動したかどうか判定
      if (notificationAppLaunchDetails != null &&
          notificationAppLaunchDetails.didNotificationLaunchApp) {
        final payload =
            notificationAppLaunchDetails.notificationResponse?.payload;
        _handleNotificationTap(payload);
      }
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('通知タップから起動の確認に失敗しました: $error'),
      );
    }
  }

  /// 通知タップ時の共通処理
  void _handleNotificationTap(String? payload) {
    try {
      if (payload != null) {
        LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
          payload,
        ).when(
          success:
              (localNotificationSettingDto) => _router.push(
                CalendarRoute(
                  id: localNotificationSettingDto.rotationId.value,
                ).location,
              ),
          failure: (error) => _router.go(const ErrorRoute().location),
        );
      } else {
        _router.go(const ErrorRoute().location);
      }
    } on Exception catch (_) {
      _router.go(const ErrorRoute().location);
    }
  }

  /// 通知権限状態の確認
  /// Returns: 通知が可能な場合はtrueを返却
  // ignore: unused_element
  Future<Result<bool>> _isAndroidPermissionGranted() async {
    try {
      final granted =
          await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          false;
      return Results.success(granted);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知権限状態の確認に失敗しました: $error'));
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
        final granted =
            await androidImplementation.requestNotificationsPermission();
        return Results.success(granted ?? false);
      }
      // Android以外のプラットフォームでは常にfalse
      return Results.success(false);
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知権限の許可に失敗しました: $error'));
    }
  }
}
