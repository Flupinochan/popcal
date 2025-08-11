import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

abstract class RotationRepository {
  // 4. ローテーショングループ作成
  Future<Result<Rotation>> createRotation(Rotation rotation);

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotation(UserId userId, RotationId rotationId);

  // 3. 特定のローテーショングループを取得
  Future<Result<Rotation?>> getRotation(UserId userId, RotationId rotationId);

  // 2. 手動ローテーショングループ一覧取得
  Future<Result<List<Rotation>>> getRotations(UserId userId);

  // 5. ローテーショングループ更新
  Future<Result<Rotation>> updateRotation(Rotation rotation);

  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<Rotation>>> watchRotations(UserId userId);
}
