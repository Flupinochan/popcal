import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

part 'email_sign_in_request_dto.freezed.dart';

// 入力用 UI => ドメイン/データ層
@freezed
sealed class EmailSignInRequestDto with _$EmailSignInRequestDto {
  const EmailSignInRequestDto._();

  const factory EmailSignInRequestDto({
    required Email email,
    required Password password,
  }) = _EmailSignInRequestDto;

  static Result<EmailSignInRequestDto> create({
    required String email,
    required String password,
  }) {
    final emailResult = Email.create(email);
    final passwordResult = Password.create(password);

    // 複数のEitherの結果を返したい場合はflatMapが有用
    return emailResult.flatMap(
      (validEmail) => passwordResult.map(
        (validPassword) =>
            EmailSignInRequestDto(email: validEmail, password: validPassword),
      ),
    );
  }

  static Result<EmailSignInRequestDto> fromJson(Map<String, dynamic> json) {
    final email = json['email'];
    final password = json['password'];

    if (email is! String || password is! String) {
      return Results.failure(ValidationFailure('Invalid JSON structure'));
    }

    return create(email: email, password: password);
  }

  Map<String, dynamic> toJson() => {
    'email': email.value,
    'password': password.value,
  };
}
