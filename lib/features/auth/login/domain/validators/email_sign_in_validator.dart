import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';

class EmailSignInValidator {
  Result<EmailSignInRequestDto> validate(EmailSignInRequestDto dto) {
    final emailError = _validateEmail(dto.email);
    if (emailError != null) {
      return Result.failure(ValidationFailure(emailError));
    }

    final passwordError = _validatePassword(dto.password);
    if (passwordError != null) {
      return Result.failure(ValidationFailure(passwordError));
    }

    return Result.success(dto);
  }

  /// バリデーション成功時は、nullを返す
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'メールアドレスを入力してください';
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'メールアドレスの形式が正しくありません';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'パスワードを入力してください';
    if (value.length < 8) return 'パスワードは8文字以上で入力してください';
    final strongPassword = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!strongPassword.hasMatch(value)) return '英字と数字を含めてください';
    return null;
  }
}
