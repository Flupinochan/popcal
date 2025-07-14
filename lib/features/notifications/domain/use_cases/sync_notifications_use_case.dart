import 'package:popcal/core/utils/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';

part 'sync_notifications_use_case.g.dart';

/// home画面表示時に以下の処理を実行し、firestoreの通知設定一覧とlocal notificationの通知設定を合わせる
/// 1. firestoreから通知設定の一覧を取得
/// 2. 通知予定のlocal notificationの一覧を取得
/// 3. 過去の時刻で通知予定にない通知をfirestoreから削除
/// 4. 未来の時刻で通知予定にない通知をlocal notificationに作成
@riverpod
class SyncNotificationsUseCase extends _$SyncNotificationsUseCase {
  @override
  FutureOr<void> build() => null;

  Future<Result<void>> execute(String ownerUserId) async {
    try {
      final rotationRepository = ref.read(rotationRepositoryProvider);
      final notificationRepository = ref.read(notificationRepositoryProvider);

      // 1. 現在のローテーショングループを取得
      final rotationGroupsResult = await rotationRepository.getRotationGroups(
        ownerUserId,
      );
      if (rotationGroupsResult.isFailure) {
        return Results.failure(rotationGroupsResult.failureOrNull!);
      }

      // 2. 現在設定されている通知IDリストを取得
      final currentNotificationsResult =
          await notificationRepository.getNotifications();
      if (currentNotificationsResult.isFailure) {
        return Results.failure(currentNotificationsResult.failureOrNull!);
      }

      final rotationGroups = rotationGroupsResult.valueOrNull!;
      final currentNotificationIds =
          currentNotificationsResult.valueOrNull!.toSet();
      final activeGroupIds =
          rotationGroups
              .where((group) => group.rotationGroupId != null)
              .map((group) => group.rotationGroupId!)
              .toSet();

      // 3. 作成が必要な通知を特定
      final missingNotificationGroups = rotationGroups.where(
        (group) =>
            group.rotationGroupId != null &&
            !currentNotificationIds.contains(group.rotationGroupId!) &&
            group.notificationTime.isAfter(DateTime.now()), // 未来の通知のみ
      );

      // 4. 削除が必要な通知を特定（過去の通知または存在しないローテーショングループ）
      final obsoleteNotificationIds = currentNotificationIds.where(
        (id) => !activeGroupIds.contains(id),
      );

      // 5. 不足している通知を作成
      for (final group in missingNotificationGroups) {
        await notificationRepository.createNotification(group);
      }

      // 6. 不要な通知を削除（個別削除メソッドが必要）
      for (final notificationId in obsoleteNotificationIds) {
        // TODO: deleteNotificationメソッドの実装が必要
        // await notificationRepository.deleteNotification(notificationId);
      }

      return Results.success(null);
    } catch (error) {
      return Results.failure(NotificationFailure('通知同期に失敗しました: $error'));
    }
  }
}
