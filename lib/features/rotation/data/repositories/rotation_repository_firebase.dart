import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/datasources/firebase_rotation_datasource.dart';
import 'package:popcal/features/rotation/data/dto/rotation_group_firebase_dto.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class RotationRepositoryFirebase implements RotationRepository {
  final FirebaseRotationDatasource _firebaseRotationDatasource;

  RotationRepositoryFirebase(this._firebaseRotationDatasource);

  @override
  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    // Entity => DTO
    final dto = RotationGroupFirebaseDto.fromEntity(rotationGroup);

    // firestoreに作成
    final result = await _firebaseRotationDatasource.createRotationGroup(dto);
    return result.when(
      success: (dto) => Results.success(dto.toEntity()),
      failure: (error) => Results.failure(error),
    );
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
