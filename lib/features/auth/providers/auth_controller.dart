import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/auth/data/dto/user_dto.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/data/dto/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/auth_provider.dart';

part 'auth_controller.g.dart';

// 複数のriverpod providerメソッドで同じ状態(.isLoading)を扱う場合はclassにまとめる
@riverpod
class AuthController extends _$AuthController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<UserDto?> build() {
    return null;
  }

  Future<Result<UserDto?>> signIn(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signInWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserDto?>> signUp(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signUpWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserDto?>> _executeAuthOperation(
    Future<Result<UserDto?>> Function() operation,
  ) async {
    state = const AsyncLoading();
    final result = await operation();
    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );
    return result;
  }

  Result<UserDto> _convertEntityToDto(Result<AppUser> entityResult) {
    return entityResult.when(
      success: (appUser) => Results.success(UserDto.fromEntity(appUser)),
      failure: (error) => Results.failure(AuthFailure(error.message)),
    );
  }
}
