import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

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
      await _showInitializationNotification();
    } else {
      print('❌ 通知権限が拒否されました');
    }

    _plugin.initialize(
      settings,
      // onDidReceiveNotificationResponse: selectNotificationStream.add,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _showInitializationNotification();
  }

  // 権限ポップアップ
  static Future<bool> _requestNotificationPermission() async {
    final androidImplementation =
        _plugin
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

  // 通知テスト用
  static Future<void> _showInitializationNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'init_channel',
      '初期化通知',
      channelDescription: '初期化完了通知',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: android);

    await _plugin.show(0, 'PopCal', '通知の準備が完了しました！', details);
  }
}
