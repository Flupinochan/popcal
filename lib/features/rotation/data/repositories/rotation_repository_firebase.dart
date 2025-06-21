import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/dto/rotation_group_firebase_dto.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class RotationRepositoryFirebase implements RotationRepository {
  final FirebaseFirestore firebaseFirestore;

  RotationRepositoryFirebase(this.firebaseFirestore);

  @override
  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    try {
      final rotationGroupFirebaseDto = RotationGroupFirebaseDto.fromEntity(rotationGroup);
      await firebaseFirestore.collection('users').doc()
      return Results.success(value)
    }
  }

  @override
  Future<Result<void>> deleteRotationGroup(String id) {
    // TODO: implement deleteRotationGroup
    throw UnimplementedError();
  }

  @override
  Future<Result<RotationGroup?>> getRotationGroup(String id) {
    // TODO: implement getRotationGroup
    throw UnimplementedError();
  }

  @override
  Future<Result<List<RotationGroup>>> getRotationGroups() {
    // TODO: implement getRotationGroups
    throw UnimplementedError();
  }

  @override
  Future<Result<RotationGroup>> updateRotationGroup(
    RotationGroup rotationGroup,
  ) {
    // TODO: implement updateRotationGroup
    throw UnimplementedError();
  }
}
