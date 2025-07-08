import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/router/router.dart';
import 'package:timezone/data/latest_all.dart';
import 'firebase_options.dart';

void main() async {
  // タイムゾーン初期化 (通知機能のタイムゾーンtzで使用)
  initializeTimeZones();

  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // flutter local notifications初期化
  await LocalNotificationsDatasource.initialize();

  // RiverPod Scope
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    LocalNotificationsDatasource.setRouter(router);

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
