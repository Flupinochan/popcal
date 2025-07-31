import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/data/dto/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';

part 'auth_view_model.g.dart';

// class形式のproviderをview modelと呼ぶ
// 複数のriverpod providerメソッドで同じ状態を扱う場合はclassにまとめる
@riverpod
class AuthViewModel extends _$AuthViewModel {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  Future<Result<AppUser?>> signIn(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(
      () => _authRepository.signInWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<Result<AppUser?>> signUp(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(
      () => _authRepository.signUpWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<Result<AppUser?>> _executeAuthOperation(
    Future<Result<AppUser?>> Function() operation,
  ) async {
    state = const AsyncLoading();
    final result = await operation();
    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }
}
