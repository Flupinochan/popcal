import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';

import '../repositories/auth_repository.dart';

class EmailSignInUseCase {
  final AuthRepository _authRepository;

  const EmailSignInUseCase(this._authRepository);

  Future<Result<UserDto?>> call(
    EmailSignInRequestDto emailSignInRequestDto,
  ) async {
    // 認証実行
    return await _authRepository.signInWithEmailAndPassword(
      emailSignInRequestDto.email,
      emailSignInRequestDto.password,
    );
  }
}
