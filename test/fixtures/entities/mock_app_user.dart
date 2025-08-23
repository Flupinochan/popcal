import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

class MockAppUser {
  static final AppUser appUser = AppUser(
    userId: UserId.create('test-user').value,
    email: Email.create('test@example.com').value,
  );
}
