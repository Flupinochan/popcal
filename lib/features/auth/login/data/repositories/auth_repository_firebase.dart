import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';
import 'package:popcal/features/auth/login/domain/repositories/auth_repository.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryFirebase(this.firebaseAuthDataSource);

  @override
  Stream<Result<AppUser?>> get authStateChanges {
    return firebaseAuthDataSource.authStateChanges.map((result) {
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
    final result = await firebaseAuthDataSource.getUser();
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
    String email,
    String password,
  ) async {
    final result = await firebaseAuthDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    return result.when(
      success: (userDto) => Results.success(userDto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> signOut() async {
    return firebaseAuthDataSource.signOut();
  }

  @override
  Future<Result<AppUser?>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await firebaseAuthDataSource.signUpWithEmailAndPassword(
      email,
      password,
    );
    return result.when(
      success: (userDto) => Results.success(userDto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }
}
