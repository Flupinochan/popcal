import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_firebase.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_group_firebase_response.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class RotationRepositoryImpl implements RotationRepository {
  final RotationRepositoryFirebase _firebaseRotationDatasource;

  RotationRepositoryImpl(this._firebaseRotationDatasource);

  // 1. 自動ローテーショングループ一覧取得
  @override
  Stream<Result<List<RotationGroup>>> watchRotationGroups(String userId) {
    return _firebaseRotationDatasource.watchRotationGroups(userId).map((
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
  Future<Result<List<RotationGroup>>> getRotationGroups(String userId) async {
    final result = await _firebaseRotationDatasource.getRotationGroups(userId);
    return result.when(
      success:
          (dtos) => Results.success(dtos.map((dto) => dto.toEntity()).toList()),
      failure: (error) => Results.failure(error),
    );
  }

  // 3. 特定のローテーショングループを取得
  @override
  Future<Result<RotationGroup?>> getRotationGroup(
    String userId,
    String rotationGroupId,
  ) async {
    final result = await _firebaseRotationDatasource.getRotationGroup(
      userId,
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
    final dto = RotationGroupFirebaseResponse.fromEntity(rotationGroup);

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
    final dto = RotationGroupFirebaseResponse.fromEntity(rotationGroup);

    final result = await _firebaseRotationDatasource.updateRotationGroup(dto);
    return result.when(
      success: (dto) => Results.success(dto.toEntity()),
      failure: (error) => Results.failure(error),
    );
  }

  // 6. ローテーショングループ削除
  @override
  Future<Result<void>> deleteRotationGroup(
    String userId,
    String rotationGroupId,
  ) async {
    final result = await _firebaseRotationDatasource.deleteRotationGroup(
      userId,
      rotationGroupId,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: (error) => Results.failure(error),
    );
  }
}
