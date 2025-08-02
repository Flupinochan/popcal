import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_view_model_dto.freezed.dart'; // freezed

@freezed
sealed class UserViewModelDto with _$UserViewModelDto {
  const UserViewModelDto._();

  const factory UserViewModelDto({
    required UserId userId,
    required Email email,
  }) = _UserViewModelDto;

  // Entity => Dto
  factory UserViewModelDto.fromEntity(AppUser entity) {
    return UserViewModelDto(userId: entity.userId, email: entity.email);
  }

  // Dto => Entity
  Result<AppUser> toEntity() {
    return Results.success(AppUser(userId: userId, email: email));
  }
}

// UI表示用の拡張メソッド
extension UserDtoDisplay on UserViewModelDto {
  String get displayName => toEntity().fold(
    (error) => 'Unknown User',
    (entity) => entity.displayName,
  );
  String get emailDomain => toEntity().fold(
    (error) => 'Unknown Domain',
    (entity) => entity.emailDomain,
  );
  String get email => toEntity().fold(
    (error) => 'Unknown Email',
    (entity) => entity.emailValue,
  );
}
