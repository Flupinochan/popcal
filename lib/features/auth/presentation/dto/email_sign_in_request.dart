import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

part 'email_sign_in_request.freezed.dart';

// 入力用 UI => ドメイン/データ層
@freezed
sealed class EmailSignInRequest with _$EmailSignInRequest {
  const factory EmailSignInRequest({
    required Email email,
    required Password password,
  }) = _EmailSignInRequest;
  const EmailSignInRequest._();

  Map<String, dynamic> toJson() => {
    'email': email.value,
    'password': password.value,
  };

  static Result<EmailSignInRequest> create({
    required String email,
    required String password,
  }) {
    final emailResult = Email.create(email);
    final passwordResult = Password.create(password);

    // 複数のEitherの結果を返したい場合はflatMapが有用
    return emailResult.flatMap(
      (validEmail) => passwordResult.map(
        (validPassword) =>
            EmailSignInRequest(email: validEmail, password: validPassword),
      ),
    );
  }

  static Result<EmailSignInRequest> fromJson(Map<String, dynamic> json) {
    final email = json['email'];
    final password = json['password'];

    if (email is! String || password is! String) {
      return Results.failure(const ValidationFailure('Invalid JSON structure'));
    }

    return create(email: email, password: password);
  }
}
