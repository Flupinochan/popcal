import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';

class CreateRotationGroupUseCase {
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;

  CreateRotationGroupUseCase(
    this._rotationRepository,
    this._notificationRepository,
  );

  Future<Result<RotationGroup>> execute(RotationGroup rotationGroup) async {
    // 1. RotationGroupを作成
    final rotationResult = await _rotationRepository.createRotationGroup(
      rotationGroup,
    );

    return rotationResult.when(
      success: (createdGroup) async {
        try {
          // 2. RotationNotificationsを作成
          final calculationResult = _notificationRepository
              .calculateNotificationSchedule(rotationGroup: createdGroup);
          if (calculationResult.isFailure) {
            throw Exception('通知計算失敗: ${calculationResult.displayText}');
          }
          final result = calculationResult.valueOrNull!;

          // 3. 各通知を作成
          for (final notification in result.notifications) {
            final createResult = await _notificationRepository
                .createNotification(notification);
            if (createResult.isFailure) {
              throw Exception('通知作成失敗: ${createResult.displayText}');
            }
          }

          // 4. RotationGroupのcurrentRotationIndexを更新
          final updatedGroup = createdGroup.copyWith(
            currentRotationIndex: result.newCurrentRotationIndex,
            lastScheduledDate:
                result.hasNotifications
                    ? result.notifications.last.notificationTime
                    : createdGroup.lastScheduledDate,
          );

          await _rotationRepository.updateRotationGroup(updatedGroup);
          return Results.success(updatedGroup);
        } catch (e) {
          // エラー時はロールバック
          await _rotationRepository.deleteRotationGroup(
            createdGroup.ownerUserId,
            createdGroup.rotationGroupId!,
          );
          return Results.failure(NotificationFailure('通知作成に失敗しました: $e'));
        }
      },
      failure: (error) => Results.failure(error),
    );
  }
}
