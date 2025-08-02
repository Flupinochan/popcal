import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/core/utils/result.dart';

/// home画面表示時に通知設定を同期するUseCase
class SyncNotificationsUseCase {
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;
  final ScheduleCalculationService _scheduleCalculationService;

  SyncNotificationsUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  Future<Result<void>> execute(String ownerUserId) async {
    // 1. ローテーショングループ一覧を取得
    final rotationGroupsResult = await _rotationRepository.getRotationGroups(
      ownerUserId,
    );
    if (rotationGroupsResult.isFailure) {
      return Results.failure(rotationGroupsResult.failureOrNull!);
    }
    final rotationGroups = rotationGroupsResult.valueOrNull!;

    // 2. 現在のローカル通知IDリストを取得
    final notificationResult = await _notificationRepository.getNotifications();
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }
    final localNotificationIds = notificationResult.valueOrNull!.toSet();

    // 3. 各ローテーショングループを同期
    for (final group in rotationGroups) {
      // 3-1. 通知スケジュールを計算
      final calculationResult = _scheduleCalculationService
          .planUpcomingNotifications(rotationGroup: group);

      if (calculationResult.isFailure) {
        print('通知計算失敗: ${group.rotationName}');
        continue;
      }

      final result = calculationResult.valueOrNull!;

      // 3-2. 不足分のみフィルタリング
      final missingNotifications =
          result.notificationSettings.where((notification) {
            return !localNotificationIds.contains(notification.notificationId);
          }).toList();

      // 3-3. 不足分の通知を作成
      for (final notification in missingNotifications) {
        final createResult = await _notificationRepository.createNotification(
          notification,
        );
        if (createResult.isFailure) {
          print(
            '通知作成失敗: ${notification.memberName} - ${notification.notificationTime}',
          );
        } else {
          print(
            '通知作成成功: ${notification.memberName} - ${notification.notificationTime}',
          );
        }
      }

      // 3-4. ローテーション状態を更新
      if (missingNotifications.isNotEmpty) {
        final updatedGroup = group.copyWith(
          currentRotationIndex: result.newCurrentRotationIndex,
          lastScheduledDate:
              result.hasNotifications
                  ? result.notificationSettings.last.notificationTime
                  : group.lastScheduledDate,
        );

        await _rotationRepository.updateRotationGroup(updatedGroup);
        print('ローテーション状態更新: ${group.rotationName}');
      }
    }

    // 4. 不要な通知を削除（オプション）
    await _cleanupOrphanedNotifications(rotationGroups, localNotificationIds);

    return Results.success(null);
  }

  /// 孤立した通知を削除
  Future<void> _cleanupOrphanedNotifications(
    List<RotationGroup> rotationGroups,
    Set<int> localNotificationIds,
  ) async {
    // 現在有効な通知IDを収集
    final validNotificationIds = <int>{};

    for (final group in rotationGroups) {
      final calculationResult = _scheduleCalculationService
          .planUpcomingNotifications(rotationGroup: group);

      if (calculationResult.isSuccess) {
        for (final notification
            in calculationResult.valueOrNull!.notificationSettings) {
          validNotificationIds.add(notification.notificationId);
        }
      }
    }

    // 不要な通知を削除
    final orphanedIds = localNotificationIds.where(
      (id) => !validNotificationIds.contains(id),
    );
    for (final id in orphanedIds) {
      await _notificationRepository.deleteNotification(id);
      print('孤立した通知を削除: $id');
    }
  }
}
