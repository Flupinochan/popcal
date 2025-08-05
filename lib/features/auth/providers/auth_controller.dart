import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/email_sign_in_request.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/auth_provider.dart';

part 'auth_controller.g.dart';

// シンプルなためUseCase層の役割も含めているが複雑化した場合は
// PresentationのロジックとしてUseCase層に切り出す
@riverpod
class AuthController extends _$AuthController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<UserResponse?> build() {
    return null;
  }

  Future<Result<UserResponse?>> signIn(EmailSignInRequest dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signInWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserResponse?>> signUp(EmailSignInRequest dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signUpWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserResponse?>> _executeAuthOperation(
    Future<Result<UserResponse?>> Function() operation,
  ) async {
    state = const AsyncLoading();
    final result = await operation();
    result.when(
      success: (dto) => state = AsyncData(dto),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );
    return result;
  }

  Result<UserResponse> _convertEntityToDto(Result<AppUser> entityResult) {
    return entityResult.when(
      success: (appUser) => Results.success(UserResponse.fromEntity(appUser)),
      failure: (error) => Results.failure(AuthFailure(error.message)),
    );
  }
}
