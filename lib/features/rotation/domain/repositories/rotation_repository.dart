import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';

abstract class RotationRepository {
  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<Rotation>>> watchRotations(String userId);

  // 2. 手動ローテーショングループ一覧取得
  Future<Result<List<Rotation>>> getRotations(String userId);

  // 3. 特定のローテーショングループを取得
  Future<Result<Rotation?>> getRotation(String userId, String rotationId);

  // 4. ローテーショングループ作成
  Future<Result<Rotation>> createRotation(Rotation rotation);

  // 5. ローテーショングループ更新
  Future<Result<Rotation>> updateRotation(Rotation rotation);

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotation(String userId, String rotationId);
}
