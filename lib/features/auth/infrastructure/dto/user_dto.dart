import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_dto.freezed.dart'; // freezed
part 'user_dto.g.dart'; // json_serializable

// 出力用 ドメイン/データ層 => UI
@freezed
sealed class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({required UserId uid, required Email email}) = _UserDto;

  // Firebase認証情報 => Dto
  static Result<UserDto> fromFirebaseUser(firebase_auth.User firebaseUser) {
    if (firebaseUser.email == null) {
      return Results.failure(
        AuthFailure('Email is required for this application'),
      );
    }

    final uidResult = UserId.create(firebaseUser.uid);
    final emailResult = Email.create(firebaseUser.email!);

    return uidResult.flatMap(
      (validUid) => emailResult.map(
        (validEmail) => UserDto(uid: validUid, email: validEmail),
      ),
    );
  }

  // Json => Dto ※Dto => Jsonは自動生成
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  static Result<UserDto> fromJsonSafe(Map<String, dynamic> json) {
    try {
      final dto = UserDto.fromJson(json);
      return Results.success(dto);
    } catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }

  // Entity => Dto
  factory UserDto.fromEntity(AppUser entity) {
    return UserDto(uid: entity.uid, email: entity.email);
  }

  // Dto => Entity
  Result<AppUser> toEntity() {
    return Results.success(AppUser(uid: uid, email: email));
  }
}

// UI表示用の拡張メソッド
extension UserDtoDisplay on UserDto {
  // emailのローカル部分（@より前）
  String get displayName => email.localPart;

  // emailのドメイン取得（@より後）
  String get emailDomain => email.domain;

  // 表示用の文字列値
  String get uidValue => uid.value;
  String get emailValue => email.value;
}
