import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';

part 'email.freezed.dart';

@freezed
sealed class Email with _$Email {
  const factory Email(String value) = _Email;
  const Email._();

  static Result<Email> create(String input) {
    if (input.isEmpty) {
      return Results.failure(ValidationFailure('メールアドレスを入力してください'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return Results.failure(ValidationFailure('正しいメールアドレス形式で入力してください'));
    }

    return Results.success(Email(input));
  }

  @override
  String toString() => value;
}
