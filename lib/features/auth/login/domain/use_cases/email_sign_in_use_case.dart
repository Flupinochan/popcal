import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';
import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';

part 'email_sign_in_use_case.g.dart';

@riverpod
class EmailSignInUseCase extends _$EmailSignInUseCase {
  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  // @mutationに置き換え予定
  Future<Result<AppUser?>> call(
    EmailSignInRequestDto emailSignInRequestDto,
  ) async {
    state = const AsyncLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.signInWithEmailAndPassword(
      emailSignInRequestDto.email,
      emailSignInRequestDto.password,
    );

    result.when(
      success: (user) => state = AsyncData(user),
      failure: (error) => state = AsyncError(error, StackTrace.current),
    );

    return result;
  }
}
