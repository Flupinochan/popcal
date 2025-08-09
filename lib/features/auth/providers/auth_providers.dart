import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_firebase.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

// DI
@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
AuthRepositoryFirebase authRepositoryFirebase(Ref ref) {
  return AuthRepositoryFirebase(ref.watch(firebaseAuthProvider));
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRepositoryFirebaseProvider));
}

// 認証状態取得Stream => auth_state.dart で Dtoへ変換
@riverpod
Stream<Result<AppUser?>> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}
