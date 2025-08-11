import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/router/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref, {required String initialLocation}) {
  final authState = ref.watch(authStateChangesForUIProvider);

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
            failure: (error) {
              if (!isAuthPage) {
                // 4. 認証エラー時に認証画面にいない => 認証画面へ
                return const LoginRoute().location;
              } else {
                return null;
              }
            },
          );
        },
        loading: () => null,
        error: (_, __) => const LoginRoute().location,
      );
    },
    routes: $appRoutes,
  );
}
