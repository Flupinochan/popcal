import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_view_model_dto.freezed.dart'; // freezed
part 'user_view_model_dto.g.dart'; // json_serializable

// ※現状はuser_firebase_dtoと同じ
// datasourcesで利用するdtoとpresentationで利用するdtoに分けているだけ
@freezed
sealed class UserViewModelDto with _$UserViewModelDto {
  const UserViewModelDto._();

  const factory UserViewModelDto({
    required UserId userId,
    required Email email,
  }) = _UserViewModelDto;

  // Firebase認証情報 => Dto
  static Result<UserViewModelDto> fromFirebaseUser(
    firebase_auth.User firebaseUser,
  ) {
    if (firebaseUser.email == null) {
      return Results.failure(
        AuthFailure('Email is required for this application'),
      );
    }

    final userIdResult = UserId.create(firebaseUser.uid);
    final emailResult = Email.create(firebaseUser.email!);

    return userIdResult.flatMap(
      (validUid) => emailResult.map(
        (validEmail) => UserViewModelDto(userId: validUid, email: validEmail),
      ),
    );
  }

  // Json => Dto ※Dto => Jsonは自動生成
  factory UserViewModelDto.fromJson(Map<String, dynamic> json) =>
      _$UserViewModelDtoFromJson(json);

  static Result<UserViewModelDto> fromJsonSafe(Map<String, dynamic> json) {
    try {
      final dto = UserViewModelDto.fromJson(json);
      return Results.success(dto);
    } catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }

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
