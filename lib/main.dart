import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/logger/logger.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/router/router.dart';
import 'package:popcal/router/routes.dart';
import 'package:timezone/data/latest_all.dart';
import 'firebase_options.dart';

void main() async {
  /// ロガー初期化
  setupLogging();
  final Logger logger = Logger("main");

  // タイムゾーン初期化 (通知機能のタイムゾーンtzで使用)
  initializeTimeZones();

  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
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

  // RiverPod Scope
  logger.info("runApp実行");
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  final Logger logger = Logger("MainApp");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(
      routerProvider(initialLocation: HomeRoute().location),
    );

    // 通知初期化
    ref.listen(notificationInitializationProvider, (previous, next) {
      next.when(
        data:
            (result) => result.when(
              success: (_) => logger.severe('通知初期化成功'),
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
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
