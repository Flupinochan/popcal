import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

class AppUser {
  const AppUser({required this.userId, required this.email});

  final UserId userId;
  final Email email;

  static bool isAuthenticated(AppUser? appUser) => appUser != null;
}
