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
      if (emailResult.isError) {
        return Result.error(emailResult.error);
      }

      final passwordResult = Password.create(dto.password);
      if (passwordResult.isError) {
        return Result.error(passwordResult.error);
      }

      final signInResult = await _authRepository.signInWithEmailAndPassword(
        emailResult.value,
        passwordResult.value,
      );
      if (signInResult.isError) {
        return Result.error(signInResult.error);
      }

      final userResponse = UserResponse.fromEntity(signInResult.value);
      return Result.ok(userResponse);
    });
  }

  Future<void> signUp(EmailSignInRequest dto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final emailResult = Email.create(dto.email);
      if (emailResult.isError) {
        return Result.error(emailResult.error);
      }

      final passwordResult = Password.create(dto.password);
      if (passwordResult.isError) {
        return Result.error(passwordResult.error);
      }

      final signUpResult = await _authRepository.signUpWithEmailAndPassword(
        emailResult.value,
        passwordResult.value,
      );
      if (signUpResult.isError) {
        return Result.error(signUpResult.error);
      }

      final userResponse = UserResponse.fromEntity(signUpResult.value);
      return Result.ok(userResponse);
    });
  }
}
