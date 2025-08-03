import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

abstract class RotationRepository {
  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<RotationGroup>>> watchRotationGroups(String userId);

  // 2. 手動ローテーショングループ一覧取得
  Future<Result<List<RotationGroup>>> getRotationGroups(String userId);

  // 3. 特定のローテーショングループを取得
  Future<Result<RotationGroup?>> getRotationGroup(
    String userId,
    String rotationGroupId,
  );

  // 4. ローテーショングループ作成
  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  );

  // 5. ローテーショングループ更新
  Future<Result<RotationGroup>> updateRotationGroup(
    RotationGroup rotationGroup,
  );

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotationGroup(
    String userId,
    String rotationGroupId,
  );
}
