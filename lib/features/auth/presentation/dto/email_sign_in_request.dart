import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_sign_in_request.freezed.dart';

/// サインイン/サインアップ共通
/// presentationからのrequestはjson変換等は不要
@freezed
sealed class EmailSignInRequest with _$EmailSignInRequest {
  const factory EmailSignInRequest({
    required String email,
    required String password,
  }) = _EmailSignInRequest;

  const EmailSignInRequest._();
}
