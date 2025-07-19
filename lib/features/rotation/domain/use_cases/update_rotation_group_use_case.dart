// lib/features/rotation/domain/use_cases/update_rotation_group_use_case.dart

import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';

class UpdateRotationGroupUseCase {
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;

  UpdateRotationGroupUseCase(
    this._rotationRepository,
    this._notificationRepository,
  );

  Future<Result<RotationGroup>> execute(RotationGroup rotationGroup) async {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未設定です'));
      }

      final targetRotationGroupId = rotationGroup.rotationGroupId!;

      print('=== ローテーショングループ更新開始 ===');
      print('ローテーション名: ${rotationGroup.rotationName}');
      print('ID: $targetRotationGroupId');
      print('更新前currentRotationIndex: ${rotationGroup.currentRotationIndex}');
      print('更新前rotationStartDate: ${rotationGroup.rotationStartDate}');

      // 1. 新しい最初の通知予定日を取得
      final firstNotificationDateResult = _notificationRepository
          .getFirstNotificationDate(
            rotationDays: rotationGroup.rotationDays,
            notificationTime: rotationGroup.notificationTime,
          );

      if (firstNotificationDateResult.isFailure) {
        return Results.failure(firstNotificationDateResult.failureOrNull!);
      }

      final firstNotificationDate = firstNotificationDateResult.valueOrNull;
      if (firstNotificationDate == null) {
        return Results.failure(ValidationFailure('最初の通知予定日が見つかりません'));
      }

      print('新しい最初の通知予定日: $firstNotificationDate');

      // 2. 対象rotationGroupIdの既存通知を削除
      print('既存通知削除開始...');
      final deleteResult = await _notificationRepository
          .deleteNotificationsByRotationGroupId(targetRotationGroupId);

      if (deleteResult.isFailure) {
        return Results.failure(deleteResult.failureOrNull!);
      }
      print('既存通知削除完了');

      // 3. RotationGroupを更新（currentRotationIndexを0にリセット、rotationStartDateを新しい最初の通知予定日に設定）
      final updatedGroup = rotationGroup.copyWith(
        updatedAt: DateTime.now().toLocal(),
        currentRotationIndex: 0, // 更新時は必ず0にリセット
        rotationStartDate: firstNotificationDate, // 新しい最初の通知予定日を設定
      );

      print(
        'currentRotationIndex更新: ${rotationGroup.currentRotationIndex} → ${updatedGroup.currentRotationIndex}',
      );
      print(
        'rotationStartDate更新: ${rotationGroup.rotationStartDate} → ${updatedGroup.rotationStartDate}',
      );

      final updateResult = await _rotationRepository.updateRotationGroup(
        updatedGroup,
      );

      if (updateResult.isFailure) {
        return Results.failure(updateResult.failureOrNull!);
      }

      final finalGroup = updateResult.valueOrNull!;
      print('ローテーショングループ更新完了');
      print('更新後currentRotationIndex: ${finalGroup.currentRotationIndex}');
      print('更新後rotationStartDate: ${finalGroup.rotationStartDate}');

      // 4. 新しい通知スケジュールを計算（未来分のみ）
      print('新しい通知スケジュール計算開始...');
      final calculationResult = _notificationRepository
          .calculateNotificationSchedule(rotationGroup: finalGroup);

      if (calculationResult.isFailure) {
        return Results.failure(calculationResult.failureOrNull!);
      }

      final result = calculationResult.valueOrNull!;
      print('計算された通知数: ${result.notifications.length}');

      // 5. 新しい通知を作成（すべて未来分）
      print('新しい通知作成開始...');
      int successCount = 0;
      for (final notification in result.notifications) {
        final createResult = await _notificationRepository.createNotification(
          notification,
        );
        if (createResult.isFailure) {
          throw Exception('通知作成失敗: ${createResult.displayText}');
        }
        successCount++;
        print(
          '[$successCount/${result.notifications.length}] 通知作成成功: ${notification.notificationTime} - ${notification.memberName}',
        );
      }

      // 6. RotationGroupの状態を最終更新
      final finalUpdatedGroup = finalGroup.copyWith(
        currentRotationIndex: result.newCurrentRotationIndex,
        lastScheduledDate:
            result.hasNotifications
                ? result.notifications.last.notificationTime
                : finalGroup.lastScheduledDate,
      );

      print(
        '最終currentRotationIndex更新: ${finalGroup.currentRotationIndex} → ${finalUpdatedGroup.currentRotationIndex}',
      );

      final finalUpdateResult = await _rotationRepository.updateRotationGroup(
        finalUpdatedGroup,
      );

      if (finalUpdateResult.isFailure) {
        return Results.failure(finalUpdateResult.failureOrNull!);
      }

      final result_final = finalUpdateResult.valueOrNull!;
      print('最終currentRotationIndex: ${result_final.currentRotationIndex}');
      print('最終rotationStartDate: ${result_final.rotationStartDate}');
      print('=== ローテーショングループ更新処理完了 ===');

      return Results.success(result_final);
    } catch (e) {
      print('=== 更新処理エラー ===');
      print('エラー内容: $e');
      return Results.failure(NotificationFailure('更新処理に失敗しました: $e'));
    }
  }
}
