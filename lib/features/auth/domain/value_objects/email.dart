import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'email.freezed.dart';

@freezed
sealed class Email with _$Email {
  const factory Email(String value) = _Email;

  factory Email.fromJson(String json) {
    final result = create(json);
    if (result.isFailure) {
      throw FormatException('Invalid Email: ${result.displayText}');
    }
    return result.valueOrNull!;
  }
  const Email._();

  String get domain => value.split('@')[1];
  String get localPart => value.split('@').first;

  String toJson() => value;
  @override
  String toString() => value;

  static Result<Email> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('メールアドレスを入力してください'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return Results.failure(const ValidationFailure('メールアドレスの形式にしてください'));
    }

    return Results.success(Email(input));
  }
}
