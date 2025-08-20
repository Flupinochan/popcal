import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/infrastructure/dto/create_rotation_firebase_request.dart';
import 'package:popcal/features/rotation/infrastructure/dto/update_rotation_firebase_request.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_firebase.dart';

class RotationRepositoryImpl implements RotationRepository {
  RotationRepositoryImpl(this._firebaseRotationDatasource);
  final RotationRepositoryFirebase _firebaseRotationDatasource;

  // 4. ローテーショングループ作成
  @override
  Future<Result<Rotation>> createRotation(Rotation rotation) async {
    final dto = CreateRotationFirebaseRequest.fromEntity(rotation);

    final firebaseResult = await _firebaseRotationDatasource.createRotation(
      dto,
    );
    if (firebaseResult.isError) {
      return Result.error(firebaseResult.error);
    }

    final entityResult = firebaseResult.value.toEntity();
    if (entityResult.isError) {
      return Result.error(entityResult.error);
    }

    return Result.ok(entityResult.value);
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
    if (result.isError) {
      return Result.error(result.error);
    }
    return const Result.ok(null);
  }

  // 3. 特定のローテーショングループを取得
  @override
  Future<Result<Rotation?>> getRotation(
    UserId userId,
    RotationId rotationId,
  ) async {
    final firebaseResult = await _firebaseRotationDatasource.getRotation(
      userId.value,
      rotationId.value,
    );
    if (firebaseResult.isError) {
      return Result.error(firebaseResult.error);
    }

    final entityResult = firebaseResult.value!.toEntity();
    if (entityResult.isError) {
      return Result.error(firebaseResult.error);
    }

    return Result.ok(entityResult.value);
  }

  // 2. 手動ローテーショングループ一覧取得
  @override
  Future<Result<List<Rotation>>> getRotations(UserId userId) async {
    final firebaseResult = await _firebaseRotationDatasource.getRotations(
      userId.value,
    );
    if (firebaseResult.isError) {
      return Result.error(firebaseResult.error);
    }

    final entitiesResult =
        firebaseResult.value.map((dto) => dto.toEntity()).toList();

    if (entitiesResult.any((result) => result.isError)) {
      return Result.error(firebaseResult.error);
    }

    return Result.ok(
      entitiesResult.map((result) => result.value).toList(),
    );
  }

  // 5. ローテーショングループ更新
  @override
  Future<Result<Rotation>> updateRotation(Rotation rotation) async {
    final dtoResult = UpdateRotationFirebaseRequest.fromEntity(rotation);
    if (dtoResult.isError) {
      return Result.error(dtoResult.error);
    }

    final firebaseResult = await _firebaseRotationDatasource.updateRotation(
      dtoResult.value,
    );
    if (firebaseResult.isError) {
      return Result.error(firebaseResult.error);
    }

    final entityResult = firebaseResult.value.toEntity();
    if (entityResult.isError) {
      return Result.error(firebaseResult.error);
    }

    return Result.ok(entityResult.value);
  }

  // 1. 自動ローテーショングループ一覧取得
  @override
  Stream<Result<List<Rotation>>> watchRotations(UserId userId) {
    return _firebaseRotationDatasource.watchRotations(userId.value).map((
      result,
    ) {
      if (result.isError) {
        return Result.error(result.error);
      }

      final dtos = result.value;

      final entities = <Rotation>[];
      for (final dto in dtos) {
        final entityResult = dto.toEntity();
        if (entityResult.isError) {
          return Result.error(entityResult.error);
        }

        entities.add(entityResult.value);
      }

      return Result.ok(entities);
    });
  }
}
