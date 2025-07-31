import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';

import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/presentation/screens/auth_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/router/routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isAuthPage = state.uri.path == Routes.auth;

          if (user.isFailure && !isAuthPage) {
            return Routes.auth;
          }

          if (user.isSuccess && isAuthPage) {
            return Routes.home;
          }

          return null;
        },
        loading: () => null,
        error: (_, __) => Routes.auth,
      );
    },
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: Routes.auth,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.rotation,
        builder: (context, state) {
          return RotationScreen();
        },
      ),
      GoRoute(
        path: Routes.rotationUpdate,
        builder: (context, state) {
          final rotationGroupId = state.pathParameters['id']!;
          return RotationScreen(rotationGroupId: rotationGroupId);
        },
      ),
      GoRoute(
        path: Routes.calendar,
        builder: (context, state) {
          final rotationGroupId = state.pathParameters['id']!;
          return CalendarScreen(rotationGroupId: rotationGroupId);
        },
      ),
    ],
  );
}
