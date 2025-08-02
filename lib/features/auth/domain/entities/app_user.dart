import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

class AppUser {
  final UserId userId;
  final Email email;

  const AppUser({required this.userId, required this.email});

  // userDtoでnullチェックするため使用してない
  static bool isAuthenticated(AppUser? appUser) => appUser != null;

  String get displayName => email.localPart;
  String get emailDomain => email.domain;
  String get uidValue => userId.value;
  String get emailValue => email.value;
}
