import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcal/core/utils/exceptions/auth_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/infrastructure/dto/user_firebase_response.dart';
import 'package:popcal/features/auth/infrastructure/dto/user_firebase_response_mapper.dart';

class AuthRepositoryFirebase {
  AuthRepositoryFirebase(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  // 認証状態(認証済 or 未認証)を監視
  Stream<Result<UserFirebaseResponse?>> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      try {
        if (firebaseUser == null) {
          return const Result.ok(null);
        }

        final dtoResult = UserFirebaseResponseMapper.fromFirebaseUser(
          firebaseUser,
        );

        if (dtoResult.isError) {
          return Result.error(dtoResult.error);
        }
        return Result.ok(dtoResult.value);
      } on FirebaseAuthException catch (error) {
        return Result.error(AuthException(_mapFirebaseError(error)));
      } on Exception catch (error) {
        return Result.error(AuthException('認証状態の監視で、予期しないエラーが発生しました: $error'));
      }
    });
  }

  // ユーザ情報を取得
  Future<Result<UserFirebaseResponse?>> getUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return const Result.ok(null);
      }

      final dtoResult = UserFirebaseResponseMapper.fromFirebaseUser(
        firebaseUser,
      );
      if (dtoResult.isError) {
        return Result.error(dtoResult.error);
      }
      return Result.ok(dtoResult.value);
    } on FirebaseAuthException catch (error) {
      return Result.error(AuthException(_mapFirebaseError(error)));
    } on Exception catch (error) {
      return Result.error(AuthException('ユーザ情報の取得で、予期しないエラーが発生しました: $error'));
    }
  }

  // Email + Passwordでサインイン
  Future<Result<UserFirebaseResponse>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return const Result.error(AuthException('メールアドレス認証認証に失敗しました'));
      }

      final dtoResult = UserFirebaseResponseMapper.fromFirebaseUser(
        credential.user!,
      );
      if (dtoResult.isError) {
        return Result.error(dtoResult.error);
      }
      return Result.ok(dtoResult.value);
    } on FirebaseAuthException catch (error) {
      return Result.error(AuthException(_mapFirebaseError(error)));
    } on Exception catch (error) {
      return Result.error(AuthException('メールアドレス認証で、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアウト
  Future<Result<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Result.ok(null);
    } on FirebaseAuthException catch (error) {
      return Result.error(AuthException(_mapFirebaseError(error)));
    } on Exception catch (error) {
      return Result.error(AuthException('サインアウトで、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアップ
  Future<Result<UserFirebaseResponse>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return const Result.error(AuthException('サインアップに失敗しました'));
      }

      final dtoResult = UserFirebaseResponseMapper.fromFirebaseUser(
        credential.user!,
      );
      if (dtoResult.isError) {
        return Result.error(dtoResult.error);
      }
      return Result.ok(dtoResult.value);
    } on FirebaseAuthException catch (error) {
      return Result.error(AuthException(_mapFirebaseError(error)));
    } on Exception catch (error) {
      return Result.error(AuthException('サインアップで、予期しないエラーが発生しました: $error'));
    }
  }

  // エラーコードに対応する日本語のエラーメッセージを定義
  String _mapFirebaseError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return 'ユーザーが見つかりません';
      case 'wrong-password':
        return 'パスワードが間違っています';
      case 'email-already-in-use':
        return 'このメールアドレスは既に使用されています';
      case 'account-exists-with-different-credential':
        return 'このメールアドレスは既に他のサービスで使用されています';
      case 'invalid-credential':
        return '無効な認証情報です';
      case 'network-request-failed':
        return 'ネットワークエラーが発生しました';
      default:
        return '予期しない認証エラーが発生しました: ${error.message}';
    }
  }
}
