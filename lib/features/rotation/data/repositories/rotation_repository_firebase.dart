import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
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
      // 作成するdocumentへのrefを作成
      final docRef =
          firebaseFirestore
              .collection('users')
              .doc(rotationGroup.ownerUserId)
              .collection('rotationGroups')
              .doc();

      // Entity => DTO
      final dto = RotationGroupFirebaseDto.fromEntity(rotationGroup);

      // Firestoreに保存
      await docRef.set(dto.toFirestore());

      // 生成されたRotationGroupIdをもとにEntityを作成
      final createdEntity = RotationGroup(
        rotationGroupId: docRef.id, // 生成されたドキュメントID
        ownerUserId: rotationGroup.ownerUserId,
        rotationName: rotationGroup.rotationName,
        rotationMembers: rotationGroup.rotationMembers,
        notificationTime: rotationGroup.notificationTime,
        createdAt: rotationGroup.createdAt,
        updatedAt: rotationGroup.updatedAt,
      );

      return Results.success(createdEntity);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの作成に失敗しました: $error'));
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
