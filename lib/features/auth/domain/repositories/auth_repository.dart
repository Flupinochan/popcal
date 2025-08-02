import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/data/dto/user_dto.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';

// 現段階ではEntityではなくDtoを返却する
abstract class AuthRepository {
  // successで未認証の場合はnullを返却
  Stream<Result<UserDto?>> get authStateChanges;
  Future<Result<UserDto?>> getUser();

  Future<Result<UserDto>> signInWithEmailAndPassword(
    Email email,
    Password password,
  );

  Future<Result<UserDto>> signUpWithEmailAndPassword(
    Email email,
    Password password,
  );

  Future<Result<void>> signOut();
}
