import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_firebase.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRepositoryFirebase _authRepositoryFirebase;

  AuthRepositoryImpl(this._authRepositoryFirebase);

  @override
  Stream<Result<AppUser?>> get authStateChanges {
    return _authRepositoryFirebase.authStateChanges.asyncMap((dtoResult) async {
      return dtoResult.when(
        success: (dto) {
          if (dto == null) {
            return Results.success(null);
          }
          return dto.toEntity().when(
            success: (entity) => Results.success(entity),
            failure: (error) => Results.failure(error),
          );
        },
        failure: (error) => Results.failure(error),
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
          success: (entity) => Results.success(entity),
          failure: (error) => Results.failure(error),
        );
      },
      failure: (error) => Results.failure(error),
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
          success: (entity) => Results.success(entity),
          failure: (error) => Results.failure(error),
        );
      },
      failure: (error) => Results.failure(error),
    );
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
          success: (entity) => Results.success(entity),
          failure: (error) => Results.failure(error),
        );
      },
      failure: (error) => Results.failure(error),
    );
  }

  @override
  Future<Result<void>> signOut() async {
    return _authRepositoryFirebase.signOut();
  }
}
