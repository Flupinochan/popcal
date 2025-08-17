import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';

part 'user_firebase_request.freezed.dart';

@freezed
sealed class UserFirebaseRequest with _$UserFirebaseRequest {
  const factory UserFirebaseRequest({
    required String userId,
    required String email,
  }) = _UserFirebaseRequest;

  factory UserFirebaseRequest.fromEntity(AppUser entity) {
    return UserFirebaseRequest(
      userId: entity.userId.value,
      email: entity.email.value,
    );
  }
}
