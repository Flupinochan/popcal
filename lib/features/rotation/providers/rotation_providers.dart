import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/rotation/data/repositories/rotation_repository_firebase.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_providers.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
RotationRepository rotationRepository(Ref ref) {
  return RotationRepositoryFirebase(ref.watch(firebaseFirestoreProvider));
}
