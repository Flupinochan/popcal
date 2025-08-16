import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/logger/logger.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/providers/deadline_providers.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/notifications/providers/notification_loader.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/firebase_options.dart';
import 'package:popcal/router/router.dart';
import 'package:popcal/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ロガー初期化
  setupLogging();
  final logger = Logger('main');

  // タイムゾーン初期化 (通知機能のタイムゾーンtzで使用)
  initializeTimeZones();

  // Firebase初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Crashlytics初期化
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Local Storage初期化
  final prefs = await SharedPreferences.getInstance();

  // RiverPod Scope
  logger.info('runApp実行');
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  final Logger logger = Logger('MainApp');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(
      routerProvider(initialLocation: const HomeRoute().location),
    );

    // 通知初期化
    ref.listen(notificationInitializationProvider, (previous, next) {
      next.when(
        data:
            (result) => result.when(
              success: (_) {
                logger.info('通知初期化成功');
                _checkNotificationLaunch(ref, router);
              },
              failure: (error) {
                logger.severe('通知初期化失敗: ${error.message}');
                // 通知機能無効化フラグをグローバルに設定すべき
                // ref.read(notificationEnabledProvider.notifier).state = false;
              },
            ),
        error: (error, stack) => logger.severe('通知初期化エラー: $error'),
        loading: () => logger.severe('通知初期化中...'),
      );
    });

    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }

  /// 通知タップからアプリを起動した場合の画面遷移処理
  Future<void> _checkNotificationLaunch(WidgetRef ref, GoRouter router) async {
    final notificationGateway = ref.read(notificationGatewayProvider);
    final result = await notificationGateway.isLaunchedFromNotification();
    result.when(
      success: (sourceId) {
        if (sourceId != null) {
          if (sourceId != SourceId.createDeadlineId()) {
            router.go(CalendarRoute(id: sourceId.value).location);
          } else {
            router.go(const HomeRoute().location);
          }
        }
      },
      failure: (_) => logger.warning('通知チェック失敗'),
    );
  }
}
