import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';
import 'package:popcal/features/auth/login/domain/validators/email_sign_in_validator.dart';

import '../repositories/auth_repository.dart';

class EmailSignInUseCase {
  final AuthRepository _authRepository;
  final EmailSignInValidator _emailSignInValidator;

  const EmailSignInUseCase(this._authRepository, this._emailSignInValidator);

  Future<Result<UserDto?>> call(
    EmailSignInRequestDto emailSignInRequestDto,
  ) async {
    // バリデーション
    final validationResult = _emailSignInValidator.validate(
      emailSignInRequestDto,
    );
    if (validationResult.isFailure) {
      final failure =
          (validationResult as Error<EmailSignInRequestDto>).failure;
      return Result.failure(failure);
    }

    // 認証実行
    return await _authRepository.signInWithEmailAndPassword(
      emailSignInRequestDto.email,
      emailSignInRequestDto.password,
    );
  }
}
