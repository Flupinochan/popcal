import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_firebase_model.freezed.dart'; // freezed
part 'user_firebase_model.g.dart'; // json_serializable

@freezed
sealed class UserFirebaseModel with _$UserFirebaseModel {
  const UserFirebaseModel._();

  const factory UserFirebaseModel({
    required UserId userId,
    required Email email,
  }) = _UserFirebaseModel;

  // ★Firebase認証情報 => Dto
  static Result<UserFirebaseModel> fromFirebaseUser(
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
        (validEmail) => UserFirebaseModel(userId: validUid, email: validEmail),
      ),
    );
  }

  // Json => Dto ※Dto => Jsonは自動生成
  factory UserFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$UserFirebaseModelFromJson(json);

  static Result<UserFirebaseModel> fromJsonSafe(Map<String, dynamic> json) {
    try {
      final dto = UserFirebaseModel.fromJson(json);
      return Results.success(dto);
    } catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }

  // Entity => Dto
  factory UserFirebaseModel.fromEntity(AppUser entity) {
    return UserFirebaseModel(userId: entity.userId, email: entity.email);
  }

  // Dto => Entity
  Result<AppUser> toEntity() {
    return Results.success(AppUser(userId: userId, email: email));
  }
}

// UI表示用の拡張メソッド
extension UserDtoDisplay on UserFirebaseModel {
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
