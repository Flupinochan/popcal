import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/notifications/infrastructure/dto/notification_entry_local_response.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationGatewayLocal {
  NotificationGatewayLocal(
    this._router,
    this._flutterLocalNotificationsPlugin,
    this._timeUtils,
    this._logger,
  );
  final GoRouter _router;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final TimeUtils _timeUtils;
  final Logger _logger;

  /// 1. 通知スケジュールを作成
  Future<Result<void>> createNotification(
    NotificationEntryLocalResponse notificationEntryLocalResponse,
  ) async {
    try {
      final now = _timeUtils.now();
      final notificationDateTime =
          notificationEntryLocalResponse.notificationDateTime;
      final dateTime = tz.TZDateTime.from(notificationDateTime, tz.local);
      final notificationId = notificationEntryLocalResponse.notificationId;
      final title = notificationEntryLocalResponse.title;
      final content = notificationEntryLocalResponse.content;
      final description = notificationEntryLocalResponse.description;
      final payloadJson = notificationEntryLocalResponse.toJsonString();

      if (notificationDateTime.isBefore(now)) {
        return Results.failure(
          NotificationFailure(
            '警告: 過去の通知作成が要求されました - $title - $content - $description',
          ),
        );
      }

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        title,
        content,
        dateTime,
        NotificationDetails(
          // channel情報はOS通知設定に表示され、それをもとにユーザがON/OFF可能
          android: AndroidNotificationDetails(
            notificationId.toString(),
            title,
            channelDescription: description,
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

  /// 4-2 特定のsourceIdの通知を削除
  Future<Result<void>> deleteNotificationsBySourceId(
    String sourceId,
  ) async {
    try {
      final notificationsResult = await getNotificationsBySourceId(sourceId);
      if (notificationsResult.isFailure) {
        return Results.failure(
          NotificationFailure(
            '通知の削除に失敗しました: ${notificationsResult.failureOrNull!}',
          ),
        );
      }

      String? errorMessage;
      for (final notification in notificationsResult.valueOrNull!) {
        try {
          final notificationId = notification.notificationId;
          await _flutterLocalNotificationsPlugin.cancel(notificationId);
          _logger.fine(
            'SourceId: $sourceId NotificationId: ${notification.notificationDateTime} 通知を削除',
          );
        } on Exception catch (error) {
          // 1つの通知削除でエラーが発生してもほかの通知削除は試みる
          errorMessage = error.toString();
          continue;
        }
      }
      return errorMessage != null
          ? Results.failure(NotificationFailure(errorMessage))
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

  /// 特定のSourceIdの通知一覧を取得
  Future<Result<List<NotificationEntryLocalResponse>>>
  getNotificationsBySourceId(String sourceId) async {
    try {
      /// 全通知を取得
      final pendingNotifications =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

      final notifications = <NotificationEntryLocalResponse>[];
      for (final pendingNotification in pendingNotifications) {
        if (pendingNotification.payload != null) {
          try {
            LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
              pendingNotification.payload!,
            ).when(
              success: (localNotificationSettingDto) {
                /// 特定のSourceIdの通知を取得
                if (localNotificationSettingDto.sourceId == sourceId) {
                  notifications.add(localNotificationSettingDto);
                }
              },
              failure: (error) => _logger.severe(error.message),
            );
          } on Exception catch (error) {
            _logger.severe(error.toString());
            continue;
          }
        }
      }
      return Results.success(notifications);
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
          final sourceId = _getSourceIdFromPayload(response.payload);
          if (sourceId == null) {
            _router.push(const ErrorRoute().location);
          }
          if (sourceId != SourceId.createDeadlineId().toString()) {
            _router.go(
              CalendarRoute(
                id: sourceId!,
              ).location,
            );
          } else {
            _router.go(const HomeRoute().location);
          }
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
  Future<Result<String?>> isLaunchedFromNotification() async {
    try {
      final notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      // 通知タップからアプリが起動したかどうか判定
      if (notificationAppLaunchDetails != null &&
          notificationAppLaunchDetails.didNotificationLaunchApp) {
        final payload =
            notificationAppLaunchDetails.notificationResponse?.payload;
        final sourceId = _getSourceIdFromPayload(payload);
        return Results.success(sourceId);
      }
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('通知タップから起動の確認に失敗しました: $error'),
      );
    }
  }

  /// 通知タップ時のpayloadからSourceIdを取得
  String? _getSourceIdFromPayload(String? payload) {
    try {
      if (payload != null) {
        final localNotificationSettingDtoResult =
            LocalNotificationSettingDtoJsonX.fromJsonStringSafe(
              payload,
            );
        if (localNotificationSettingDtoResult.isSuccess) {
          return localNotificationSettingDtoResult.valueOrNull!.sourceId;
        }
      }
    } on Exception catch (_) {}
    return null;
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
