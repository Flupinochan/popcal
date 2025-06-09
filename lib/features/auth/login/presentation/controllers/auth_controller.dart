import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';
import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  /// メールアドレスとパスワードでサインイン
  Future<Result<AppUser?>> signIn(String email, String password) async {
    state = const AsyncLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.signInWithEmailAndPassword(
      email,
      password,
    );

    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }

  /// メールアドレスとパスワードでサインアップ
  Future<Result<AppUser?>> signUp(String email, String password) async {
    state = const AsyncLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.signUpWithEmailAndPassword(
      email,
      password,
    );

    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }

  /// サインアウト
  Future<Result<void>> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.signOut();

    if (result.isSuccess) {
      state = const AsyncData(null);
    }

    return result;
  }
}
