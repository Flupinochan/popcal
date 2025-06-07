import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';

class EmailSignInValidator {
  Result<String> validateEmail(String value) {
    if (value.trim().isEmpty) {
      return Result.failure(ValidationFailure('メールアドレスを入力してください'));
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return Result.failure(ValidationFailure('メールアドレスの形式が正しくありません'));
    }
    return Result.success('バリデーション成功');
  }

  Result<String> validatePassword(String value) {
    if (value.trim().isEmpty) {
      return Result.failure(ValidationFailure('パスワードを入力してください'));
    }
    if (value.length < 6) {
      return Result.failure(ValidationFailure('パスワードは6文字以上で入力してください'));
    }
    final strongPassword = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$',
    );
    if (!strongPassword.hasMatch(value)) {
      return Result.failure(ValidationFailure('英字と数字を含めてください'));
    }
    return Result.success('バリデーション成功');
  }
}
