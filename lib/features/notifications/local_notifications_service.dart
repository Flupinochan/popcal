import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // 初期化処理
  static Future<void> initialize() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      'app_icon',
    );
    const InitializationSettings settings = InitializationSettings(
      android: android,
    );
    _plugin.initialize(
      settings,
      // onDidReceiveNotificationResponse: selectNotificationStream.add,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _showInitializationNotification();
  }

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
