import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsDatasource {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static GoRouter? _router;
  static void setRouter(GoRouter router) {
    _router = router;
  }

  // 初期化処理
  static Future<void> initialize() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      // 'app_icon',
      '@mipmap/ic_launcher',
    );
    const InitializationSettings settings = InitializationSettings(
      android: android,
    );

    // 権限をリクエストして結果を確認
    final bool hasPermission = await _requestNotificationPermission();
    if (hasPermission) {
      print('✅ 通知権限が許可されました');
    } else {
      print('❌ 通知権限が拒否されました');
    }
    // 権限状態の確認
    await _isAndroidPermissionGranted();

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

    // 通知テスト
    await _showZonedSchedule();
  }

  // 通知許可を求める権限確認ポップアップを表示
  static Future<bool> _requestNotificationPermission() async {
    final androidImplementation =
        _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidImplementation != null) {
      final bool? granted =
          await androidImplementation.requestNotificationsPermission();
      return granted ?? false;
    }
    return false; // Android以外のプラットフォームでは常にfalse
  }

  // 権限状態の確認
  static Future<void> _isAndroidPermissionGranted() async {
    final bool granted =
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ??
        false;
    print('通知権限許可状態: $granted');
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
}
