import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';

part 'email.freezed.dart';

@freezed
sealed class Email with _$Email {
  const factory Email(String value) = _Email;
  const Email._();

  static Result<Email> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(ValidationFailure('メールアドレスを入力してください'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return Results.failure(ValidationFailure('メールアドレスの形式にしてください'));
    }

    return Results.success(Email(input));
  }

  factory Email.fromJson(String json) {
    final result = create(json);
    if (result.isFailure) {
      throw FormatException('Invalid Email: ${result.displayText}');
    }
    return result.valueOrNull!;
  }

  String toJson() => value;

  String get localPart => value.split('@')[0];
  String get domain => value.split('@')[1];

  @override
  String toString() => value;
}
