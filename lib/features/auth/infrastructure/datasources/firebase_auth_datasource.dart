import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/infrastructure/dto/user_firebase_dto.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  // 認証状態(認証済 or 未認証)を監視
  Stream<Result<UserFirebaseDto?>> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      try {
        if (firebaseUser != null) {
          final dtoResult = UserFirebaseDto.fromFirebaseUser(firebaseUser);
          return dtoResult.when(
            success: (dto) => Results.success(dto),
            failure: (error) => Results.failure(AuthFailure(error.message)),
          );
        } else {
          return Results.success(null);
        }
      } on FirebaseAuthException catch (error) {
        return Results.failure(AuthFailure(_mapFirebaseError(error)));
      } catch (error) {
        return Results.failure(AuthFailure('認証状態の監視で、予期しないエラーが発生しました: $error'));
      }
    });
  }

  // ユーザ情報を取得
  Future<Result<UserFirebaseDto?>> getUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Results.success(null);
      }
      final dtoResult = UserFirebaseDto.fromFirebaseUser(firebaseUser);
      return dtoResult.when(
        success: (dto) => Results.success(dto),
        failure: (error) => Results.failure(AuthFailure(error.message)),
      );
    } on FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('ユーザ情報の取得で、予期しないエラーが発生しました: $error'));
    }
  }

  // Email + Passwordでサインイン
  Future<Result<UserFirebaseDto>> signInWithEmailAndPassword(
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
      final dtoResult = UserFirebaseDto.fromFirebaseUser(credential.user!);
      return dtoResult.when(
        success: (dto) => Results.success(dto),
        failure: (error) => Results.failure(AuthFailure(error.message)),
      );
    } on FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('メールアドレス認証で、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアップ
  Future<Result<UserFirebaseDto>> signUpWithEmailAndPassword(
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
      final dtoResult = UserFirebaseDto.fromFirebaseUser(credential.user!);
      return dtoResult.when(
        success: (dto) => Results.success(dto),
        failure: (error) => Results.failure(AuthFailure(error.message)),
      );
    } on FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('サインアップで、予期しないエラーが発生しました: $error'));
    }
  }

  // サインアウト
  Future<Result<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Results.success(null);
    } on FirebaseAuthException catch (error) {
      return Results.failure(AuthFailure(_mapFirebaseError(error)));
    } catch (error) {
      return Results.failure(AuthFailure('サインアウトで、予期しないエラーが発生しました: $error'));
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
