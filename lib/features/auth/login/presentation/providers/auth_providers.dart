import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/login/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/login/presentation/validators/email_sign_in_validator.dart';

part 'auth_providers.g.dart';

// Dependency Injection および Global State管理
@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseAuthDataSource firebaseAuthDataSource(Ref ref) {
  return FirebaseAuthDataSource(ref.watch(firebaseAuthProvider));
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(firebaseAuthDataSourceProvider));
}

@riverpod
Stream<Result<AppUser?>> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
EmailSignInValidator emailSignInValidator(Ref ref) {
  return EmailSignInValidator();
}
