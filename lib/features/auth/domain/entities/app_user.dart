import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

part 'app_user.freezed.dart';

@freezed
sealed class AppUser with _$AppUser {
  const factory AppUser({
    required UserId userId,
    required Email email,
  }) = _AppUser;

  const AppUser._();
}
