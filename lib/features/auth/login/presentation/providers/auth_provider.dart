import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/login/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/login/data/dto/user_dto.dart';
import 'package:popcal/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/login/domain/use_cases/email_sign_in_use_case.dart';
import 'package:popcal/features/auth/login/presentation/validators/email_sign_in_validator.dart';

// Dependency Injection および Global State管理

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseAuthDataSource = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(ref.read(firebaseAuthProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(firebaseAuthDataSource));
});

final authStateChangesProvider = StreamProvider<UserDto?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

final emailSignInValidatorProvider = Provider<EmailSignInValidator>((ref) {
  return EmailSignInValidator();
});

final emailSignInUseCaseProvider = Provider<EmailSignInUseCase>((ref) {
  return EmailSignInUseCase(ref.read(authRepositoryProvider));
});
