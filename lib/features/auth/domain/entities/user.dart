import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

class AppUser {
  final UserId uid;
  final Email email;

  const AppUser({required this.uid, required this.email});
}
