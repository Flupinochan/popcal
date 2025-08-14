import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_firebase.dart';

// 2層 Entity <=> DTO変換
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRepositoryFirebase);
  final AuthRepositoryFirebase _authRepositoryFirebase;

  @override
  Stream<Result<AppUser?>> get authStateChanges {
    return _authRepositoryFirebase.authStateChanges.asyncMap((dtoResult) async {
      return dtoResult.when(
        success: (dto) {
          if (dto == null) {
            return Results.success(null);
          }
          return dto.toEntity().when(
            success: Results.success,
            failure: Results.failure,
          );
        },
        failure: Results.failure,
      );
    });
  }

  @override
  Future<Result<AppUser?>> getUser() async {
    final dtoResult = await _authRepositoryFirebase.getUser();
    return dtoResult.when(
      success: (dto) {
        if (dto == null) {
          return Results.success(null);
        }
        return dto.toEntity().when(
          success: Results.success,
          failure: Results.failure,
        );
      },
      failure: Results.failure,
    );
  }

  @override
  Future<Result<AppUser>> signInWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final dtoResult = await _authRepositoryFirebase.signInWithEmailAndPassword(
      email.value,
      password.value,
    );

    return dtoResult.when(
      success: (dto) {
        return dto.toEntity().when(
          success: Results.success,
          failure: Results.failure,
        );
      },
      failure: Results.failure,
    );
  }

  @override
  Future<Result<void>> signOut() async {
    return _authRepositoryFirebase.signOut();
  }

  @override
  Future<Result<AppUser>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  ) async {
    final dtoResult = await _authRepositoryFirebase.signUpWithEmailAndPassword(
      email.value,
      password.value,
    );

    return dtoResult.when(
      success: (dto) {
        return dto.toEntity().when(
          success: Results.success,
          failure: Results.failure,
        );
      },
      failure: Results.failure,
    );
  }
}
