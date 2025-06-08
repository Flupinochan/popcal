import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';
import 'package:popcal/features/auth/login/presentation/screens/auth_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/router/routes.dart';

// Router.neglectでルーティングすれば履歴なしでルーティング

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    // refreshListenable: GoRouter,
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
        path: Routes.auth,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen();
        },
        routes: [
          GoRoute(
            path: Routes.search,
            builder: (context, state) {
              return const Text("profileScreen");
            },
          ),
        ],
      ),
    ],
  );
});
