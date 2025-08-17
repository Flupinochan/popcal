import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';

part 'user_response.freezed.dart';

/// presentationへのresponseはfromEntityのみ定義
@freezed
sealed class UserResponse with _$UserResponse {
  const factory UserResponse({
    required String userId,
    required String emailLocalPart,
    required String emailDomain,
  }) = _UserResponse;

  factory UserResponse.fromEntity(AppUser entity) {
    return UserResponse(
      userId: entity.userId.value,
      emailLocalPart: entity.email.localPart,
      emailDomain: entity.email.domain,
    );
  }

  const UserResponse._();
}
