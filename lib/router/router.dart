import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/providers/auth_loader.dart';
import 'package:popcal/router/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref, {required String initialLocation}) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return authState.when(
        data: (result) {
          final isAuthPage =
              state.matchedLocation == const LoginRoute().location;
          return result.when(
            success: (user) {
              if (user != null && isAuthPage) {
                // 1. 認証済かつ認証画面にいる => ホーム画面へ
                return const HomeRoute().location;
                // 2. 未認証かつ認証画面にいない => 認証画面へ
              } else if (user == null && !isAuthPage) {
                return const LoginRoute().location;
                // 3. 認証済かつ認証画面にいない => 画面遷移しない
              } else {
                return null;
              }
            },
            // 4. 認証エラー時に認証画面にいない => 認証画面へ
            failure: (_) => !isAuthPage ? const LoginRoute().location : null,
          );
        },
        loading: () => null,
        error: (_, _) => const LoginRoute().location,
      );
    },
    routes: $appRoutes,
  );
}
