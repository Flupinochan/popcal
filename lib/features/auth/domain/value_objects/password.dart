import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';

extension type Password._(String value) {
  static Result<Password> create(String input) {
    if (input.trim().isEmpty) {
      return const Result.error(ValidationException('パスワードを入力してください'));
    }

    if (input.length < 6) {
      return const Result.error(ValidationException('6文字以上で入力してください'));
    }

    final hasUpperCase = input.contains(RegExp('[A-Z]'));
    final hasLowerCase = input.contains(RegExp('[a-z]'));
    final hasDigits = input.contains(RegExp('[0-9]'));

    if (!hasUpperCase || !hasLowerCase || !hasDigits) {
      return const Result.error(ValidationException('大文字、小文字、数字が必要です'));
    }

    return Result.ok(Password._(input.trim()));
  }
}
