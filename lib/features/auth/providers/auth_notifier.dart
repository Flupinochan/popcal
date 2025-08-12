import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/presentation/dto/email_sign_in_request.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<UserResponse?> build() => null;

  Future<Result<UserResponse>> signIn(EmailSignInRequest dto) async {
    return _executeAuthOperation(
      () => _authRepository.signInWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<Result<UserResponse>> signUp(EmailSignInRequest dto) async {
    return _executeAuthOperation(
      () => _authRepository.signUpWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<Result<UserResponse>> _executeAuthOperation(
    Future<Result<AppUser>> Function() operation,
  ) async {
    state = await AsyncValue.guard(() async {
      final entityResult = await operation();
      if (entityResult.isFailure) {
        throw Exception(entityResult.displayText);
      }

      return UserResponse.fromEntity(entityResult.valueOrNull!);
    });

    return state.when(
      data: (response) {
        if (response == null) {
          return Results.failure(const AuthFailure('予期しないエラー'));
        }
        return Results.success(response);
      },
      error: (error, _) => Results.failure(AuthFailure(error.toString())),
      loading: () => Results.failure(const AuthFailure('予期しないエラー')),
    );
  }
}
