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
import 'package:stack_trace/stack_trace.dart';
import 'package:timezone/data/latest_all.dart';
import 'firebase_options.dart';

void main() async {
  /// ロガー初期化
  setupLogging();
  final Logger logger = Logger("main");

  /// Widget の build メソッド内 (レンダリング中) のエラー処理
  /// 1. setState の実行中
  /// 2. Widget のライフサイクルメソッド (initState, dispose)
  /// 3. アニメーション実行
  /// デフォルトでは、FlutterError.presentError で赤い画面を表示
  FlutterError.onError = (details) {
    if (kDebugMode) {
      // debug環境では、エラーの赤い画面を表示
      FlutterError.presentError(details);
      if (details.stack != null) {
        logger.severe("Widgetで予期せぬエラーが発生", Trace.from(details.stack!).terse);
      }
    }
    // release環境では、エラーを表示せず続行
    // ※一部のwidgetが表示されないかもしれないが、ほかの機能は正常動作する可能性があるため
  };

  /// 非同期処理のエラー処理
  /// ※runZonedGuardedは使用しない
  ///   処理が複雑で他のエラー処理と競合しバグが発生しやすいため
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      logger.severe("非同期処理で予期せぬエラーが発生", Trace.from(stack));
      return false;
    } else {
      // コンソールへエラー出力しない
      return true;
    }
  };

  // タイムゾーン初期化 (通知機能のタイムゾーンtzで使用)
  initializeTimeZones();

  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
