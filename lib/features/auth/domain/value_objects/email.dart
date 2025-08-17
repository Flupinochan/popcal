import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'email.freezed.dart';
part 'email.g.dart';

@freezed
sealed class Email with _$Email {
  const factory Email(String value) = _Email;

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  const Email._();

  String get domain => value.split('@')[1];
  String get localPart => value.split('@').first;

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
