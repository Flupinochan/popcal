import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/use_cases/create_rotation_use_case.dart';
import 'package:popcal/features/rotation/use_cases/update_rotation_use_case.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_firebase.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_impl.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

part 'rotation_providers.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
RotationRepositoryFirebase rotationRepositoryFirebase(Ref ref) {
  return RotationRepositoryFirebase(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(timeUtilsProvider),
  );
}

@riverpod
RotationRepository rotationRepository(Ref ref) {
  return RotationRepositoryImpl(ref.watch(rotationRepositoryFirebaseProvider));
}

@riverpod
CreateRotationUseCase createRotationUseCase(Ref ref) {
  return CreateRotationUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationGatewayProvider),
    ref.watch(rotationCalculationServiceProvider),
  );
}

@riverpod
UpdateRotationUseCase updateRotationUseCase(Ref ref) {
  return UpdateRotationUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationGatewayProvider),
    ref.watch(rotationCalculationServiceProvider),
  );
}
