import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

abstract class AuthRepository {
  // 未認証の場合はsuccessでnullを返却
  Stream<Result<AppUser?>> get authStateChanges;

  Future<Result<AppUser?>> getUser();
  Future<Result<AppUser>> signInWithEmailAndPassword(
    Email email,
    Password password,
  );
  Future<Result<void>> signOut();
  Future<Result<AppUser>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  );
}
