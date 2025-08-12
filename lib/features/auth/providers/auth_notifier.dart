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
  FutureOr<Result<UserResponse>?> build() async => null;

  Future<void> signIn(EmailSignInRequest dto) async {
    return _executeAuthOperation(
      () => _authRepository.signInWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<void> signUp(EmailSignInRequest dto) async {
    return _executeAuthOperation(
      () => _authRepository.signUpWithEmailAndPassword(dto.email, dto.password),
    );
  }

  Future<void> _executeAuthOperation(
    Future<Result<AppUser>> Function() operation,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final entityResult = await operation();
      if (entityResult.isFailure) {
        return Results.failure(AuthFailure(entityResult.displayText));
      }

      final userResponse = UserResponse.fromEntity(entityResult.valueOrNull!);

      return Results.success(userResponse);
    });
  }
}
