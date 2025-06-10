import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';

class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  // 認証状態(認証済 or 未認証)を監視
  Stream<Result<UserDto?>> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      try {
        if (firebaseUser != null) {
          return Results.success(UserDto.fromFirebaseUser(firebaseUser));
        } else {
          return Results.failure(AuthFailure('未認証です'));
        }
      } on firebase_auth.FirebaseAuthException catch (error) {
        return Results.failure(AuthFailure(_mapFirebaseError(error)));
      } catch (error) {
        return Results.failure(AuthFailure('認証状態の監視で、予期しないエラーが発生しました: $error'));
      }
    });
  }

  // ユーザ情報を取得
  Future<Result<UserDto?>> getUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Results.failure(AuthFailure('未認証または存在しないユーザを取得しようとしました'));
      }
      final userDto = UserDto.fromFirebaseUser(firebaseUser);
      return Results.success(userDto);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('ユーザ情報の取得で、予期しないエラーが発生しました: $error'));
    }
  }

  // Email + Passwordでサインイン
  Future<Result<UserDto>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return Results.failure(AuthFailure('メールアドレス認証認証に失敗しました'));
      }
      final userDto = UserDto.fromFirebaseUser(credential.user!);
      return Results.success(userDto);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('メールアドレス認証で、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアウト
  Future<Result<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Results.success(null);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('サインアウトで、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアップ
  Future<Result<UserDto>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return Results.failure(AuthFailure('サインアップに失敗しました'));
      }
      final userDto = UserDto.fromFirebaseUser(credential.user!);
      return Results.success(userDto);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('サインアップで、予期しないエラーが発生しました: $error'));
    }
  }

  // エラーコードに対応する日本語のエラーメッセージを定義
  String _mapFirebaseError(firebase_auth.FirebaseAuthException error) {
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
