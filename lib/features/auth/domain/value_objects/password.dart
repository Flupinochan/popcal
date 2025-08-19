import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

extension type Password._(String value) {
  static Result<Password> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('パスワードを入力してください'));
    }

    if (input.length < 6) {
      return Results.failure(const ValidationFailure('6文字以上で入力してください'));
    }

    final hasUpperCase = input.contains(RegExp('[A-Z]'));
    final hasLowerCase = input.contains(RegExp('[a-z]'));
    final hasDigits = input.contains(RegExp('[0-9]'));

    if (!hasUpperCase || !hasLowerCase || !hasDigits) {
      return Results.failure(const ValidationFailure('大文字、小文字、数字が必要です'));
    }

    return Results.success(Password._(input.trim()));
  }
}
