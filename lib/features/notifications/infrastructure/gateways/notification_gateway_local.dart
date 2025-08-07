import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/infrastructure/dto/notification_entry_local_response.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationGatewayLocal {
  final GoRouter _router;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final Logger _logger;

  NotificationGatewayLocal(
    this._router,
    this._flutterLocalNotificationsPlugin,
    this._logger,
  );

  /// 0-1. 初期化
  /// 通知アイコン設定
  /// アプリ起動中に通知をタップした際の動作を設定
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

  /// 0-2. アプリが起動していない場合に、通知タップからアプリを起動した場合
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
    NotificationEntryLocalResponse notificationSettingDto,
  ) async {
    try {
      if (notificationSettingDto.notificationTime.isBefore(
        DateTime.now().toLocal(),
      )) {
        return Results.failure(
          NotificationFailure(
            '警告: 過去の通知作成が要求されました - ${notificationSettingDto.notificationTime} - ${notificationSettingDto.memberName}',
          ),
        );
      }

      final payloadJson = notificationSettingDto.toJsonString();

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationSettingDto.notificationId,
        notificationSettingDto.title,
        notificationSettingDto.content,
        tz.TZDateTime.from(notificationSettingDto.notificationTime, tz.local),
        NotificationDetails(
          // channel情報はOS通知設定に表示され、それをもとにユーザがON/OFF可能
          android: AndroidNotificationDetails(
            notificationSettingDto.rotationId,
            notificationSettingDto.title,
            channelDescription: notificationSettingDto.description,
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

  /// 4-1. 特定の通知を削除
  Future<Result<void>> deleteNotification(int notificationId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(notificationId);
      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知の削除に失敗しました: $error'));
    }
  }

  /// 4-2 特定のrotationIdの通知を削除
  Future<Result<void>> deleteNotificationsByRotationId(
    String rotationId,
  ) async {
    final List<PendingNotificationRequest> pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    int deletedCount = 0;
    String? errorMessage;
    for (final notification in pendingNotifications) {
      if (notification.payload != null) {
        final dtoResult = LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
          notification.payload!,
        );
        dtoResult.when(
          success: (localNotificationSettingDto) {
            if (localNotificationSettingDto.rotationId == rotationId) {
              try {
                _flutterLocalNotificationsPlugin.cancel(notification.id);
                deletedCount++;
              } catch (error) {
                errorMessage = error.toString();
              }
            }
          },
          failure: (error) => errorMessage = error.message,
        );
      }
    }
    if (errorMessage != null) {
      return Results.failure(NotificationFailure(errorMessage!));
    } else {
      return Results.success(null);
    }
  }

  /// 4-3. 全通知を削除
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

      for (final notification in pendingNotifications) {
        String dateTime = '日時不明';

        try {
          // 🔥 通知IDから日時を復元（yyyyMMdd形式）
          final dateInt = notification.id;
          final month = (dateInt % 10000) ~/ 100;
          final day = dateInt % 100;

          dateTime = '$month/$day';
        } catch (e) {
          // 復元に失敗した場合は日時不明のまま
        }

        _logger.fine(
          '$dateTime | ${notification.title} | ${notification.body}',
        );
      }

      if (pendingNotifications.isEmpty) {
        _logger.fine('設定済み通知はありません');
      }

      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知一覧の取得に失敗しました: $error'));
    }
  }

  /// 通知タップ時の共通処理
  void _handleNotificationTap(String? payload) {
    try {
      if (payload != null) {
        final dtoResult = LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
          payload,
        );
        dtoResult.when(
          success:
              (localNotificationSettingDto) => _router.push(
                Routes.calendarPath(localNotificationSettingDto.rotationId),
              ),
          failure: (error) => _router.push(Routes.home),
        );
      } else {
        _router.push(Routes.home);
      }
    } catch (error) {
      _router.push(Routes.home);
    }
  }
}
