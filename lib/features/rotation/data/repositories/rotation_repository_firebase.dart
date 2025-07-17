import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/datasources/firebase_rotation_datasource.dart';
import 'package:popcal/features/rotation/data/dto/rotation_group_firebase_dto.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class RotationRepositoryFirebase implements RotationRepository {
  final FirebaseRotationDatasource _firebaseRotationDatasource;

  RotationRepositoryFirebase(this._firebaseRotationDatasource);

  // 1. 自動ローテーショングループ一覧取得
  @override
  Stream<Result<List<RotationGroup>>> watchRotationGroups(String ownerUserId) {
    return _firebaseRotationDatasource.watchRotationGroups(ownerUserId).map((
      result,
    ) {
      return result.when(
        success:
            (dtos) =>
                Results.success(dtos.map((dto) => dto.toEntity()).toList()),
        failure: (error) => Results.failure(error),
      );
    });
  }

  // 2. 手動ローテーショングループ一覧取得
  @override
  Future<Result<List<RotationGroup>>> getRotationGroups(
    String ownerUserId,
  ) async {
    final result = await _firebaseRotationDatasource.getRotationGroups(
      ownerUserId,
    );
    return result.when(
      success:
          (dtos) => Results.success(dtos.map((dto) => dto.toEntity()).toList()),
      failure: (error) => Results.failure(error),
    );
  }

  // 3. 特定のローテーショングループを取得
  @override
  Future<Result<RotationGroup?>> getRotationGroup(
    String ownerUserId,
    String rotationGroupId,
  ) async {
    final result = await _firebaseRotationDatasource.getRotationGroup(
      ownerUserId,
      rotationGroupId,
    );
    return result.when(
      success: (dto) => Results.success(dto?.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }

  // 4. ローテーショングループ作成
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

  // 5. ローテーショングループ更新
  @override
  Future<Result<RotationGroup>> updateRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    final dto = RotationGroupFirebaseDto.fromEntity(rotationGroup);

    final result = await _firebaseRotationDatasource.updateRotationGroup(dto);
    return result.when(
      success: (dto) => Results.success(dto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }

  // 6. ローテーショングループ削除
  @override
  Future<Result<void>> deleteRotationGroup(
    String ownerUserId,
    String rotationGroupId,
  ) async {
    final result = await _firebaseRotationDatasource.deleteRotationGroup(
      ownerUserId,
      rotationGroupId,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }
}
