import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/data/dto/user_dto.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepositoryFirebase(this._firebaseAuthDataSource);

  @override
  Stream<Result<UserDto?>> get authStateChanges {
    return _firebaseAuthDataSource.authStateChanges.map((result) {
      return result.when(
        success: (userDto) => Results.success(userDto),
        failure: (error) => Results.failure(error),
      );
    });
  }

  @override
  Future<Result<UserDto?>> getUser() async {
    final result = await _firebaseAuthDataSource.getUser();
    return result.when(
      success: (userDto) => Results.success(userDto),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<UserDto>> signInWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final result = await _firebaseAuthDataSource.signInWithEmailAndPassword(
      email.value,
      password.value,
    );
    return result.when(
      success: (userDto) => Results.success(userDto),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<UserDto>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final result = await _firebaseAuthDataSource.signUpWithEmailAndPassword(
      email.value,
      password.value,
    );
    return result.when(
      success: (userDto) => Results.success(userDto),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> signOut() async {
    return _firebaseAuthDataSource.signOut();
  }
}
