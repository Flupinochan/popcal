import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_firebase_response.freezed.dart'; // freezed
part 'user_firebase_response.g.dart'; // json_serializable

@freezed
sealed class UserFirebaseResponse with _$UserFirebaseResponse {
  const factory UserFirebaseResponse({
    required UserId userId,
    required Email email,
  }) = _UserFirebaseResponse;

  // Entity => Dto
  factory UserFirebaseResponse.fromEntity(AppUser entity) {
    return UserFirebaseResponse(userId: entity.userId, email: entity.email);
  }

  // Json => Dto ※Dto => Jsonは自動生成
  factory UserFirebaseResponse.fromJson(Map<String, dynamic> json) =>
      _$UserFirebaseResponseFromJson(json);
  const UserFirebaseResponse._();

  // Dto => Entity
  Result<AppUser> toEntity() {
    return Results.success(AppUser(userId: userId, email: email));
  }

  // ★Firebase認証情報 => Dto
  static Result<UserFirebaseResponse> fromFirebaseUser(
    firebase_auth.User firebaseUser,
  ) {
    if (firebaseUser.email == null) {
      return Results.failure(
        const AuthFailure('Email is required for this application'),
      );
    }

    final userIdResult = UserId.create(firebaseUser.uid);
    final emailResult = Email.create(firebaseUser.email);

    return userIdResult.flatMap(
      (validUid) => emailResult.map(
        (validEmail) =>
            UserFirebaseResponse(userId: validUid, email: validEmail),
      ),
    );
  }

  static Result<UserFirebaseResponse> fromJsonSafe(Map<String, dynamic> json) {
    try {
      final dto = UserFirebaseResponse.fromJson(json);
      return Results.success(dto);
    } on Exception catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }
}

// UI表示用の拡張メソッド
extension UserDtoDisplay on UserFirebaseResponse {
  String get displayName => toEntity().fold(
    (error) => 'Unknown User',
    (entity) => entity.email.localPart,
  );
  String get email => toEntity().fold(
    (error) => 'Unknown Email',
    (entity) => entity.email.value,
  );
  String get emailDomain => toEntity().fold(
    (error) => 'Unknown Domain',
    (entity) => entity.email.domain,
  );
}
