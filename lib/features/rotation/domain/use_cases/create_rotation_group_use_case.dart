import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';

part 'create_rotation_group_use_case.g.dart';

// 以下2つのRepositoryを利用
// 1. rotationRepository: ローテーショングループを作成
// 2. notificationRepository: 通知を作成

@riverpod
class CreateRotationGroupUseCase extends _$CreateRotationGroupUseCase {
  @override
  FutureOr<void> build() => null;

  Future<Result<RotationGroup>> execute(RotationGroup rotationGroup) async {
    final rotationRepository = ref.read(rotationRepositoryProvider);
    final notificationRepository = ref.read(notificationRepositoryProvider);

    // 1. ローテーショングループを作成
    final rotationResult = await rotationRepository.createRotationGroup(
      rotationGroup,
    );

    return rotationResult.when(
      success: (createdGroup) async {
        // 2. 通知を作成
        final notificationResult = await notificationRepository
            .createNotification(createdGroup);

        return notificationResult.when(
          success: (_) {
            // 両方成功した場合のみ成功
            return Results.success(createdGroup);
          },
          failure: (notificationError) async {
            // 通知作成エラー時はローテーショングループを削除（ロールバック）
            try {
              await rotationRepository.deleteRotationGroup(
                createdGroup.ownerUserId,
                createdGroup.rotationGroupId!,
              );
              print("ロールバックしました: $notificationError");
            } catch (rollbackError) {
              // ロールバックに失敗した場合はログ出力
              print('ロールバックに失敗しました: $rollbackError');
            }
            // 作成失敗時にエラー画面表示が必要
            return Results.failure(notificationError);
          },
        );
      },
      // ローテーショングループの作成エラー時
      failure: (error) => Results.failure(error),
    );
  }
}
