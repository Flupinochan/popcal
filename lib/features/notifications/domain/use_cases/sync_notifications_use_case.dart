import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';

/// home画面表示時に以下の処理を実行し、firestoreの通知設定一覧とlocal notificationの通知設定を合わせる
/// 1. firestoreから通知設定の一覧を取得
/// 2. 通知予定のlocal notificationの一覧を取得
/// 3. 過去の時刻で通知予定にない通知をfirestoreから削除
/// 4. 未来の時刻で通知予定にない通知をlocal notificationに作成

@riverpod
Future<Result<void>> execute(Ref ref, String ownerUserId) async {
  try {
    final rotationRepository = ref.read(rotationRepositoryProvider);
    final notificationRepository = ref.read(notificationRepositoryProvider);

    // 1. Firebaseからローテーショングループの一覧を取得
    final rotationGroupsResult = await rotationRepository.getRotationGroups(
      ownerUserId,
    );
    if (rotationGroupsResult.isFailure) {
      return Results.failure(rotationGroupsResult.failureOrNull!);
    }
    final rotationGroups = rotationGroupsResult.valueOrNull!;

    // 2. 現在ローカルに設定されている通知IDリストを取得
    final notificationResult = await notificationRepository.getNotifications();
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }
    final localNotificationIds = notificationResult.valueOrNull!.toList();

    // 3. Firebaseから削除する過去のローテーショングループの一覧を取得
    final pastRotationGroups =
        rotationGroups
            .where(
              (rotationGroup) =>
                  rotationGroup.notificationTime.isBefore(DateTime.now()),
            )
            .toList();

    // 4. 過去のローテーショングループを削除
    for (final rotationGroup in pastRotationGroups) {
      if (rotationGroup.rotationGroupId == null) {
        continue;
      }
      await rotationRepository.deleteRotationGroup(
        ownerUserId,
        rotationGroup.rotationGroupId!,
      );
      print('firebaseから過去の通知を削除: ${rotationGroup.rotationName}');
    }

    // 5. Firebaseから未来のローテーショングループの一覧を取得
    final futureRotationGroups =
        rotationGroups
            .where(
              (rotationGroup) =>
                  rotationGroup.notificationTime.isAfter(DateTime.now()),
            )
            .toList();

    // 5. 不足している通知を作成
    for (final rotationGroup in futureRotationGroups) {
      if (localNotificationIds.contains(rotationGroup.notificationId)) {
        continue;
      }
      await notificationRepository.createNotification(rotationGroup);
      print('不足している通知を作成: ${rotationGroup.rotationName}');
    }

    return Results.success(null);
  } catch (error) {
    return Results.failure(NotificationFailure('通知同期に失敗しました: $error'));
  }
}
