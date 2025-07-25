import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepositoryFirebase(this._firebaseAuthDataSource);

  @override
  Stream<Result<AppUser?>> get authStateChanges {
    return _firebaseAuthDataSource.authStateChanges.map((result) {
      return result.when(
        success:
            (userDto) =>
                userDto != null
                    ? Results.success(userDto.toEntity())
                    : Results.failure(AuthFailure('未認証です')),
        failure: (error) => Results.failure(error),
      );
    });
  }

  @override
  Future<Result<AppUser?>> getUser() async {
    final result = await _firebaseAuthDataSource.getUser();
    return result.when(
      success:
          (userDto) =>
              userDto != null
                  ? Results.success(userDto.toEntity())
                  : Results.failure(AuthFailure('ユーザーが存在しません')),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<AppUser?>> signInWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final result = await _firebaseAuthDataSource.signInWithEmailAndPassword(
      email.value,
      password.value,
    );
    return result.when(
      success: (userDto) => Results.success(userDto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> signOut() async {
    return _firebaseAuthDataSource.signOut();
  }

  @override
  Future<Result<AppUser?>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final result = await _firebaseAuthDataSource.signUpWithEmailAndPassword(
      email.value,
      password.value,
    );
    return result.when(
      success: (userDto) => Results.success(userDto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }
}
