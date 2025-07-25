import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';

part 'password.freezed.dart';

@freezed
sealed class Password with _$Password {
  const factory Password(String value) = _Password;
  const Password._();

  static Result<Password> create(String input) {
    if (input.isEmpty) {
      return Results.failure(ValidationFailure('パスワードを入力してください'));
    }

    if (input.length < 6) {
      return Results.failure(ValidationFailure('パスワードは6文字以上で入力してください'));
    }

    final hasUpperCase = input.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = input.contains(RegExp(r'[a-z]'));
    final hasDigits = input.contains(RegExp(r'[0-9]'));

    if (!hasUpperCase || !hasLowerCase || !hasDigits) {
      return Results.failure(ValidationFailure('パスワードは大文字、小文字、数字を含む必要があります'));
    }

    return Results.success(Password(input));
  }

  // セキュリティ上 パスワードを文字列で取得しない
  @override
  String toString() => '********';
}
