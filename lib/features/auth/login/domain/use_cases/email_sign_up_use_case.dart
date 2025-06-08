import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';

part 'email_sign_up_use_case.g.dart';

@riverpod
class EmailSignUpUseCase extends _$EmailSignUpUseCase {
  @override
  FutureOr<UserDto?> build() {
    return null;
  }

  // @mutationに置き換え予定
  Future<Result<UserDto?>> call(
    EmailSignInRequestDto emailSignInRequestDto,
  ) async {
    state = const AsyncLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.signUpWithEmailAndPassword(
      emailSignInRequestDto.email,
      emailSignInRequestDto.password,
    );

    result.when(
      success: (userDto) => state = AsyncData(userDto),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }
}
