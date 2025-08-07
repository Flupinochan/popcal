import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';

import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/router/routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateForUIProvider);

  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return authState.when(
        data: (result) {
          final isAuthPage = state.uri.path == Routes.auth;
          return result.when(
            success: (user) {
              if (user != null && isAuthPage) {
                // 認証済かつ認証画面にいる => ホーム画面へ
                return Routes.home;
                // 未認証かつ認証画面にいない => 認証画面へ
              } else if (user == null && !isAuthPage) {
                return Routes.auth;
                // 画面遷移しない
              } else {
                return null;
              }
            },
            failure: (error) {
              if (!isAuthPage) {
                // 認証画面にいない => 認証画面へ
                return Routes.auth;
              } else {
                return null;
              }
            },
          );
        },
        loading: () => null,
        error: (_, __) => Routes.auth,
      );
    },
    routes: [
      GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: Routes.auth, builder: (context, state) => LoginScreen()),
      GoRoute(
        path: Routes.rotation,
        builder: (context, state) => RotationScreen(),
      ),
      GoRoute(
        path: Routes.rotationUpdate,
        builder: (context, state) {
          final rotationId = state.pathParameters['id']!;
          return RotationScreen(rotationId: rotationId);
        },
      ),
      GoRoute(
        path: Routes.calendar,
        builder: (context, state) {
          final rotationId = state.pathParameters['id']!;
          return CalendarScreen(rotationId: rotationId);
        },
      ),
    ],
  );
}
