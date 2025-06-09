import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';

abstract class AuthRepository {
  // 認証状態(認証済 or 未認証)を監視
  Stream<Result<AppUser?>> get authStateChanges;

  // ユーザ情報を取得
  Future<Result<AppUser?>> getUser();

  // Email + Passwordでサインイン
  Future<Result<AppUser?>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  // サインアウト
  Future<Result<void>> signOut();

  // サインアップ (Email + Password)
  Future<Result<AppUser?>> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  // // その他の方法でサインイン（必要に応じて実装）
  // Future<Result<AppUser?>> signInWithGoogle();
  // Future<Result<AppUser?>> signInWithGitHub();
  // Future<Result<AppUser?>> signInAnonymously();

  // // Passwordリセット（必要に応じて実装）
  // Future<Result<void>> resetPassword(String email);
}
