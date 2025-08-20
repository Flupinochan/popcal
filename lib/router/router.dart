import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/features/auth/providers/auth_handlers.dart';
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

          // 認証エラーの場合
          if (result.isError) {
            // 認証画面にいる場合
            if (isAuthPage) {
              return null;
            }
            return const LoginRoute().location;
          }

          final user = result.value;

          // 認証済かつ認証画面にいる => ホーム画面へ
          if (user != null && isAuthPage) {
            return const HomeRoute().location;
          }

          // 未認証かつ認証画面にいない => 認証画面へ
          if (user == null && !isAuthPage) {
            return const LoginRoute().location;
          }

          // 認証済かつ認証画面にいない => 画面遷移しない
          return null;
        },
        loading: () => null,
        error: (_, _) => const LoginRoute().location,
      );
    },
    routes: $appRoutes,
  );
}
