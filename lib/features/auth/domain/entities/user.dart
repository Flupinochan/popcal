import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

class AppUser {
  final UserId uid;
  final Email email;

  const AppUser({required this.uid, required this.email});

  // userDtoでnullチェックするため使用してない
  static bool isAuthenticated(AppUser? user) => user != null;

  String get displayName => email.localPart;
  String get emailDomain => email.domain;
  String get uidValue => uid.value;
  String get emailValue => email.value;
}
