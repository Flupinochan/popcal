import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

// data層 (dto) => domain層 (entity) <= presentation層 (dto)
abstract class AuthRepository {
  // successで未認証の場合はnullを返却
  Stream<Result<AppUser?>> get authStateChanges;

  Future<Result<AppUser?>> getUser();
  Future<Result<AppUser>> signInWithEmailAndPassword(
    Email email,
    Password password,
  );
  Future<Result<AppUser>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  );
  Future<Result<void>> signOut();
}
