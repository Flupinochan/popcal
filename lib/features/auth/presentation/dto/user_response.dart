import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_response.freezed.dart'; // freezed

@freezed
sealed class UserResponse with _$UserResponse {
  const UserResponse._();

  const factory UserResponse({required UserId userId, required Email email}) =
      _UserResponse;

  // Entity => Dto
  factory UserResponse.fromEntity(AppUser entity) {
    return UserResponse(userId: entity.userId, email: entity.email);
  }

  // Dto => Entity
  Result<AppUser> toEntity() {
    return Results.success(AppUser(userId: userId, email: email));
  }
}

// UI表示用の拡張メソッド
extension UserDtoDisplay on UserResponse {
  String get displayName => toEntity().fold(
    (error) => 'Unknown User',
    (entity) => entity.email.localPart,
  );
  String get emailDomain => toEntity().fold(
    (error) => 'Unknown Domain',
    (entity) => entity.email.domain,
  );
  String get email => toEntity().fold(
    (error) => 'Unknown Email',
    (entity) => entity.email.value,
  );
}
