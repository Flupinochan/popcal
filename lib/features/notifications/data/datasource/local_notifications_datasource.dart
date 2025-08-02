import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/data/dto/notification_payload_dto.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
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
          _handleNotificationTap(response.payload);
        },
        // 2.アプリが起動していない場合に通知をタップした際の動作
        // ※通知をタップしたらデフォルトでアプリが起動するため、アプリ起動時の処理で遷移するため不要
        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      // 権限要求
      await _requestNotificationPermission();
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
        _handleNotificationTap(payload);
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
    NotificationSetting notification,
  ) async {
    try {
      if (notification.notificationTime.isBefore(DateTime.now().toLocal())) {
        print(
          '警告: 過去の通知作成が要求されました - ${notification.notificationTime} - ${notification.memberName}',
        );
        return Results.success(null);
      }

      final payloadDto = NotificationPayloadDto.fromEntity(notification);
      final payloadJson = payloadDto.toJsonString();

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
        payload: payloadJson, // タップ時に渡すデータ
      );
      // ログ出力
      await logPendingNotifications();
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

  /// 4-1. 特定の通知を削除(キャンセル)
  Future<Result<void>> deleteNotification(int notificationId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(notificationId);
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 4-2. 特定のrotationGroupIdの通知を削除(キャンセル)
  Future<Result<void>> deleteNotificationsByRotationGroupId(
    String rotationGroupId,
  ) async {
    try {
      final List<PendingNotificationRequest> pendingNotifications =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

      int deletedCount = 0;
      for (final notification in pendingNotifications) {
        if (notification.payload != null) {
          try {
            final notificationPayload =
                NotificationPayloadDtoJsonX.fromJsonString(
                  notification.payload!,
                );
            if (notificationPayload.rotationGroupId == rotationGroupId) {
              await _flutterLocalNotificationsPlugin.cancel(notification.id);
              deletedCount++;
              print('通知削除: ID=${notification.id}, GroupId=$rotationGroupId');
            }
          } catch (e) {
            // JSON解析に失敗した場合はスキップ
            print('通知payload解析失敗: ${notification.id} - $e');
            continue;
          }
        }
      }

      print('削除した通知数: $deletedCount (対象GroupId: $rotationGroupId)');
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('特定通知の削除に失敗しました: $error'));
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
      pendingNotifications.sort((a, b) => a.id.compareTo(b.id));

      print('=== 設定済み通知一覧 (${pendingNotifications.length}件) ===');

      for (final notification in pendingNotifications) {
        String dateTime = '日時不明';

        try {
          // 🔥 通知IDから日時を復元（yyyyMMdd形式）
          final dateInt = notification.id;
          final year = dateInt ~/ 10000;
          final month = (dateInt % 10000) ~/ 100;
          final day = dateInt % 100;

          dateTime = '$month/$day';
        } catch (e) {
          // 復元に失敗した場合は日時不明のまま
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

  /// 通知タップ時の処理
  void _handleNotificationTap(String? payload) {
    if (payload != null) {
      try {
        final notificationPayload = NotificationPayloadDtoJsonX.fromJsonString(
          payload,
        );
        _router.push(Routes.calendarPath(notificationPayload.rotationGroupId));
      } catch (e) {
        // JSON解析に失敗した場合
        _router.push(Routes.calendarPath(payload));
      }
    }
  }
}
