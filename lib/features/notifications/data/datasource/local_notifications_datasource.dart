import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsDatasource {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static GoRouter? _router;
  static void setRouter(GoRouter router) {
    _router = router;
  }

  /// 初期化処理
  /// 通知アイコンや通知をタップした際の動作を設定
  static Future<void> initialize() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
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
        if (payload != null && _router != null) {
          // 画面遷移
          _router!.push(Routes.rotationUpdatePath(payload));
        }
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
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

  // 通知テスト1
  static Future<void> _showInitializationNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'init_channel',
      '初期化通知',
      channelDescription: '初期化完了通知',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'PopCal',
      '通知の準備が完了しました！',
      details,
    );
  }

  // 通知テスト2
  static Future<void> _showZonedSchedule() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'タイトル',
      'ボディ',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'full screen channel id',
          'full screen channel name',
          channelDescription: 'full screen channel description',
          // priority: Priority.high,
          // importance: Importance.high,
          // fullScreenIntent: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> createNotification() async {}
}
