import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'user_firebase_response.freezed.dart';

@freezed
sealed class UserFirebaseResponse with _$UserFirebaseResponse {
  const factory UserFirebaseResponse({
    required String userId,
    required String email,
  }) = _UserFirebaseResponse;

  const UserFirebaseResponse._();

  // Dto => Entity
  Result<AppUser> toEntity() {
    final userIdResult = UserId.create(userId);
    if (userIdResult.isFailure) {
      return Results.failure(AuthFailure(userIdResult.displayText));
    }

    final emailResult = Email.create(email);
    if (emailResult.isFailure) {
      return Results.failure(AuthFailure(emailResult.displayText));
    }

    return Results.success(
      AppUser(
        userId: userIdResult.valueOrNull!,
        email: emailResult.valueOrNull!,
      ),
    );
  }
}
