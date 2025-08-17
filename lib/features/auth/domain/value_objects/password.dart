import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'password.freezed.dart';
part 'password.g.dart';

@freezed
sealed class Password with _$Password {
  const factory Password(String value) = _Password;

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);

  const Password._();

  // セキュリティ上 パスワードを文字列で取得しない
  @override
  String toString() => '********';

  static Result<Password> create(String? input) {
    if (input == null || input.trim().isEmpty) {
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

    return Results.success(Password(input));
  }
}
