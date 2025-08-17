import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_firebase.dart';
import 'package:popcal/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRepositoryFirebaseProvider));
}

@riverpod
AuthRepositoryFirebase authRepositoryFirebase(Ref ref) {
  return AuthRepositoryFirebase(ref.watch(firebaseAuthProvider));
}

@riverpod
FirebaseAuth firebaseAuth(Ref _) {
  return FirebaseAuth.instance;
}
