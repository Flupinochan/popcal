import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  // 初期値はnull
  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  /// メールアドレスとパスワードでサインイン
  Future<Result<AppUser?>> signIn(String email, String password) async {
    // Result<AppUser?> がstate
    // stateは単一の状態管理する値
    // AsyncLoadingでローディング状態
    state = const AsyncLoading();

    final result = await _authRepository.signInWithEmailAndPassword(
      email,
      password,
    );

    result.when(
      success: (user) {
        // AsyncDataは成功状態
        state = AsyncData(user);
      },
      // AsyncErrorは失敗状態
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }

  /// メールアドレスとパスワードでサインアップ
  Future<Result<AppUser?>> signUp(String email, String password) async {
    state = const AsyncLoading();

    final result = await _authRepository.signUpWithEmailAndPassword(
      email,
      password,
    );

    result.when(
      success: (user) {
        state = AsyncData(user);
      },
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }

  /// サインアウト
  Future<Result<void>> signOut() async {
    final result = await _authRepository.signOut();

    if (result.isSuccess) {
      state = const AsyncData(null);
    }

    return result;
  }
}
