import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/data/dto/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/data/repositories/auth_repository_firebase.dart';
import 'package:popcal/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';

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
  return AuthRepositoryFirebase(ref.watch(firebaseAuthDataSourceProvider));
}

@riverpod
Stream<Result<UserDto?>> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}
