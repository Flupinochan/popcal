import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_response.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_firebase.dart';

class RotationRepositoryImpl implements RotationRepository {
  RotationRepositoryImpl(this._firebaseRotationDatasource);
  final RotationRepositoryFirebase _firebaseRotationDatasource;

  // 4. ローテーショングループ作成
  @override
  Future<Result<Rotation>> createRotation(Rotation rotation) async {
    // Entity => DTO
    final dto = RotationFirebaseResponse.fromEntity(rotation);

    // firestoreに作成
    final result = await _firebaseRotationDatasource.createRotation(dto);
    return result.when(
      success: (dto) => Results.success(dto.toEntity()),
      failure: Results.failure,
    );
  }

  // 6. ローテーショングループ削除
  @override
  Future<Result<void>> deleteRotation(
    UserId userId,
    RotationId rotationId,
  ) async {
    final result = await _firebaseRotationDatasource.deleteRotation(
      userId.value,
      rotationId.value,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  // 3. 特定のローテーショングループを取得
  @override
  Future<Result<Rotation?>> getRotation(
    UserId userId,
    RotationId rotationId,
  ) async {
    final result = await _firebaseRotationDatasource.getRotation(
      userId.value,
      rotationId.value,
    );
    return result.when(
      success: (dto) => Results.success(dto?.toEntity()),
      failure: Results.failure,
    );
  }

  // 2. 手動ローテーショングループ一覧取得
  @override
  Future<Result<List<Rotation>>> getRotations(UserId userId) async {
    final result = await _firebaseRotationDatasource.getRotations(userId.value);
    return result.when(
      success:
          (dtos) => Results.success(dtos.map((dto) => dto.toEntity()).toList()),
      failure: Results.failure,
    );
  }

  // 5. ローテーショングループ更新
  @override
  Future<Result<Rotation>> updateRotation(Rotation rotation) async {
    final dto = RotationFirebaseResponse.fromEntity(rotation);

    final result = await _firebaseRotationDatasource.updateRotation(dto);
    return result.when(
      success: (dto) => Results.success(dto.toEntity()),
      failure: Results.failure,
    );
  }

  // 1. 自動ローテーショングループ一覧取得
  @override
  Stream<Result<List<Rotation>>> watchRotations(UserId userId) {
    return _firebaseRotationDatasource.watchRotations(userId.value).map((
      result,
    ) {
      return result.when(
        success:
            (dtos) =>
                Results.success(dtos.map((dto) => dto.toEntity()).toList()),
        failure: Results.failure,
      );
    });
  }
}
