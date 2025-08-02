import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/use_cases/create_rotation_group_use_case.dart';
import 'package:popcal/features/rotation/domain/use_cases/update_rotation_group_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/datasources/firebase_rotation_datasource.dart';
import 'package:popcal/features/rotation/data/repositories/rotation_repository_firebase.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

part 'rotation_providers.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseRotationDatasource firebaseRotationDatasource(Ref ref) {
  return FirebaseRotationDatasource(ref.watch(firebaseFirestoreProvider));
}

@riverpod
RotationRepository rotationRepository(Ref ref) {
  return RotationRepositoryFirebase(
    ref.watch(firebaseRotationDatasourceProvider),
  );
}

@riverpod
Stream<Result<List<RotationGroup>>> rotationGroupsStream(
  Ref ref,
  String ownerUserId,
) {
  // 依存がInterface RepositoryのみなのでScreenでrotationGroupsStreamを使用してOK
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  return rotationRepository.watchRotationGroups(ownerUserId);
}

@riverpod
CreateRotationGroupUseCase createRotationGroupUseCase(Ref ref) {
  return CreateRotationGroupUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationRepositoryProvider),
    ref.watch(scheduleCalculationServiceRepositoryProvider),
  );
}

@riverpod
UpdateRotationGroupUseCase updateRotationGroupUseCase(Ref ref) {
  return UpdateRotationGroupUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationRepositoryProvider),
    ref.watch(scheduleCalculationServiceRepositoryProvider),
  );
}
