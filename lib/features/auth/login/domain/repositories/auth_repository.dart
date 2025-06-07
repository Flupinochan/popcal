import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';

class AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  // final LocalCacheDataSource localCacheDataSource;

  AuthRepository(this.firebaseAuthDataSource);

  // 認証状態(認証済 or 未認証)を監視
  // ※ errorがthrowされるため追加の処理が必要
  Stream<UserDto?> get authStateChanges {
    return firebaseAuthDataSource.authStateChanges;
  }

  // ユーザ情報を取得
  Future<Result<UserDto?>> getUser() async {
    return firebaseAuthDataSource.getUser();
  }

  // Email + Passwordでサインイン
  Future<Result<UserDto?>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return firebaseAuthDataSource.signInWithEmailAndPassword(email, password);
  }

  // サインアウト
  Future<Result<void>> signOut() async {
    return firebaseAuthDataSource.signOut();
  }

  // // その他の方法でサインイン
  // Future<User> signInWithGoogle();
  // Future<User> signInWithGitHub();
  // Future<User> signInAnonymously();
  // // Email + Passwordでユーザを新規作成(サインアップ)
  // Future<User> signUpWithEmailAndPassword(String email, String password);
  // // Passwordリセット
  // Future<void> resetPassword(String email);
}
