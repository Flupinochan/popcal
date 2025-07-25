import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

part 'email_sign_in_request_dto.freezed.dart';

@freezed
sealed class EmailSignInRequestDto with _$EmailSignInRequestDto {
  const factory EmailSignInRequestDto({
    required Email email,
    required Password password,
  }) = _EmailSignInRequestDto;

  const EmailSignInRequestDto._();

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

  factory EmailSignInRequestDto.fromJson(Map<String, dynamic> json) {
    final createResult = create(
      email: json['email'] as String,
      password: json['password'] as String,
    );

    return createResult.when(
      success: (dto) => dto,
      failure:
          (error) => throw FormatException('Invalid DTO: ${error.message}'),
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email.value,
    'password': password.value,
  };
}
