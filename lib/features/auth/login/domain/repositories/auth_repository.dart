import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';

class AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  // final LocalCacheDataSource localCacheDataSource;

  AuthRepository(this.firebaseAuthDataSource);

  // 認証状態(認証済 or 未認証)を監視
  Stream<Result<AppUser?>> get authStateChanges {
    return firebaseAuthDataSource.authStateChanges.map((result) {
      return result.when(
        success:
            (userDto) =>
                userDto != null
                    ? Result.success(userDto.toEntity())
                    : Result.failure(AuthFailure('未認証です')),
        failure: (error) => Result.failure(error),
      );
    });
  }

  // ユーザ情報を取得
  Future<Result<AppUser?>> getUser() async {
    final result = await firebaseAuthDataSource.getUser();
    return result.when(
      success:
          (userDto) =>
              userDto != null
                  ? Result.success(userDto.toEntity())
                  : Result.failure(AuthFailure('ユーザーが存在しません')),
      failure: (error) => Result.failure(error),
    );
  }

  // Email + Passwordでサインイン
  Future<Result<AppUser?>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await firebaseAuthDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    return result.when(
      success: (userDto) => Result.success(userDto.toEntity()),
      failure: (error) => Result.failure(error),
    );
  }

  // サインアウト
  Future<Result<void>> signOut() async {
    return firebaseAuthDataSource.signOut();
  }

  // サインアップ (Email + Password)
  Future<Result<AppUser?>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await firebaseAuthDataSource.signUpWithEmailAndPassword(
      email,
      password,
    );
    return result.when(
      success: (userDto) => Result.success(userDto.toEntity()),
      failure: (error) => Result.failure(error),
    );
  }

  // // その他の方法でサインイン
  // Future<User> signInWithGoogle();
  // Future<User> signInWithGitHub();
  // Future<User> signInAnonymously();

  // // Passwordリセット
  // Future<void> resetPassword(String email);
}
