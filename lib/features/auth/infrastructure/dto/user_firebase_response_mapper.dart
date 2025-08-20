import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/exceptions/auth_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/infrastructure/dto/user_firebase_response.dart';

part 'user_firebase_response_mapper.freezed.dart';

/// FirebaseのResponseをDtoのResponseに変換するMapper
@freezed
sealed class UserFirebaseResponseMapper with _$UserFirebaseResponseMapper {
  const factory UserFirebaseResponseMapper({
    required String userId,
    required String email,
  }) = _UserFirebaseResponseMapper;

  const UserFirebaseResponseMapper._();

  static Result<UserFirebaseResponse> fromFirebaseUser(
    firebase_auth.User firebaseUser,
  ) {
    try {
      if (firebaseUser.email == null) {
        return const Result.error(
          AuthException('Email is required for this application'),
        );
      }

      return Result.ok(
        UserFirebaseResponse(
          userId: firebaseUser.uid,
          email: firebaseUser.email!,
        ),
      );
    } on Exception catch (error) {
      return Result.error(
        AuthException('Firebaseから予期せぬ応答が返されました: $error'),
      );
    }
  }
}
