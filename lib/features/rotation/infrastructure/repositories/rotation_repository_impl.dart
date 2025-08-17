import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_request.dart';
import 'package:popcal/features/rotation/infrastructure/repositories/rotation_repository_firebase.dart';

class RotationRepositoryImpl implements RotationRepository {
  RotationRepositoryImpl(this._firebaseRotationDatasource);
  final RotationRepositoryFirebase _firebaseRotationDatasource;

  // 4. ローテーショングループ作成
  @override
  Future<Result<Rotation>> createRotation(Rotation rotation) async {
    final dto = RotationFirebaseRequest.fromEntity(rotation);

    final firebaseResult = await _firebaseRotationDatasource.createRotation(
      dto,
    );
    if (firebaseResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    final entityResult = firebaseResult.valueOrNull!.toEntity();
    if (entityResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    return Results.success(entityResult.valueOrNull!);
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
    if (result.isFailure) {
      return Results.failure(RotationFailure(result.displayText));
    }
    return Results.success(result.valueOrNull);
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
    if (firebaseResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    final entityResult = firebaseResult.valueOrNull!.toEntity();
    if (entityResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    return Results.success(entityResult.valueOrNull);
  }

  // 2. 手動ローテーショングループ一覧取得
  @override
  Future<Result<List<Rotation>>> getRotations(UserId userId) async {
    final firebaseResult = await _firebaseRotationDatasource.getRotations(
      userId.value,
    );
    if (firebaseResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    final entitiesResult =
        firebaseResult.valueOrNull!.map((dto) => dto.toEntity()).toList();

    if (entitiesResult.any((result) => result.isFailure)) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    return Results.success(
      entitiesResult.map((result) => result.valueOrNull!).toList(),
    );
  }

  // 5. ローテーショングループ更新
  @override
  Future<Result<Rotation>> updateRotation(Rotation rotation) async {
    final dto = RotationFirebaseRequest.fromEntity(rotation);

    final firebaseResult = await _firebaseRotationDatasource.updateRotation(
      dto,
    );
    if (firebaseResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    final entityResult = firebaseResult.valueOrNull!.toEntity();
    if (entityResult.isFailure) {
      return Results.failure(RotationFailure(firebaseResult.displayText));
    }

    return Results.success(entityResult.valueOrNull!);
  }

  // 1. 自動ローテーショングループ一覧取得
  @override
  Stream<Result<List<Rotation>>> watchRotations(UserId userId) {
    return _firebaseRotationDatasource.watchRotations(userId.value).map((
      result,
    ) {
      return result.when(
        success: (dtos) {
          final entities = <Rotation>[];
          for (final dto in dtos) {
            final entityResult = dto.toEntity();
            if (entityResult.isFailure) {
              return Results.failure(RotationFailure(entityResult.displayText));
            }
            entities.add(entityResult.valueOrNull!);
          }
          return Results.success(entities);
        },
        failure: Results.failure,
      );
    });
  }
}
