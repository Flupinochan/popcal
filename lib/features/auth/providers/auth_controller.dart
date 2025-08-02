import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/auth/infrastructure/dto/user_firebase_dto.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/auth_provider.dart';

part 'auth_controller.g.dart';

// 複数のriverpod providerメソッドで同じ状態(.isLoading)を扱う場合はclassにまとめる
// シンプルなためUseCase層の役割も含めているが複雑化した場合は
// PresentationのロジックとしてUseCase層に切り出す
@riverpod
class AuthController extends _$AuthController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<UserFirebaseDto?> build() {
    return null;
  }

  Future<Result<UserFirebaseDto?>> signIn(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signInWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserFirebaseDto?>> signUp(EmailSignInRequestDto dto) async {
    return _executeAuthOperation(() async {
      final entityResult = await _authRepository.signUpWithEmailAndPassword(
        dto.email,
        dto.password,
      );
      return _convertEntityToDto(entityResult);
    });
  }

  Future<Result<UserFirebaseDto?>> _executeAuthOperation(
    Future<Result<UserFirebaseDto?>> Function() operation,
  ) async {
    state = const AsyncLoading();
    final result = await operation();
    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );
    return result;
  }

  Result<UserFirebaseDto> _convertEntityToDto(Result<AppUser> entityResult) {
    return entityResult.when(
      success:
          (appUser) => Results.success(UserFirebaseDto.fromEntity(appUser)),
      failure: (error) => Results.failure(AuthFailure(error.message)),
    );
  }
}
