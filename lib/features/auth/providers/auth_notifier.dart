import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final emailResult = Email.create(dto.email);
      if (emailResult.isFailure) {
        return Results.failure(AuthFailure(emailResult.displayText));
      }

      final passwordResult = Password.create(dto.password);
      if (passwordResult.isFailure) {
        return Results.failure(AuthFailure(passwordResult.displayText));
      }

      final signInResult = await _authRepository.signInWithEmailAndPassword(
        emailResult.valueOrNull!,
        passwordResult.valueOrNull!,
      );
      if (signInResult.isFailure) {
        return Results.failure(AuthFailure(signInResult.displayText));
      }

      final userResponse = UserResponse.fromEntity(signInResult.valueOrNull!);
      return Results.success(userResponse);
    });
  }

  Future<void> signUp(EmailSignInRequest dto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final emailResult = Email.create(dto.email);
      if (emailResult.isFailure) {
        return Results.failure(AuthFailure(emailResult.displayText));
      }

      final passwordResult = Password.create(dto.password);
      if (passwordResult.isFailure) {
        return Results.failure(AuthFailure(passwordResult.displayText));
      }

      final signUpResult = await _authRepository.signUpWithEmailAndPassword(
        emailResult.valueOrNull!,
        passwordResult.valueOrNull!,
      );
      if (signUpResult.isFailure) {
        return Results.failure(AuthFailure(signUpResult.displayText));
      }

      final userResponse = UserResponse.fromEntity(signUpResult.valueOrNull!);
      return Results.success(userResponse);
    });
  }
}
