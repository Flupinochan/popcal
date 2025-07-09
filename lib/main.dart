import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/router/router.dart';
import 'package:timezone/data/latest_all.dart';
import 'firebase_options.dart';

void main() async {
  // タイムゾーン初期化 (通知機能のタイムゾーンtzで使用)
  initializeTimeZones();

  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // RiverPod Scope
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final notificationProvider = ref.watch(notificationRepositoryProvider);

    return FutureBuilder<Result<void>>(
      // local notification初期化
      future: notificationProvider.initializeNotification(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp.router(
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
