// lib/features/rotation/domain/use_cases/create_rotation_group_use_case.dart

import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';

class CreateRotationGroupUseCase {
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;
  final ScheduleCalculationService _scheduleCalculationService;

  CreateRotationGroupUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  Future<Result<RotationGroup>> execute(RotationGroup rotationGroup) async {
    print('=== ローテーショングループ作成開始 ===');
    print('ローテーション名: ${rotationGroup.rotationName}');
    print('メンバー: ${rotationGroup.rotationMembers}');
    print('入力されたcurrentRotationIndex: ${rotationGroup.currentRotationIndex}');

    // 1. 最初の通知予定日を取得
    final firstNotificationDateResult = _scheduleCalculationService
        .findNextRotationDate(
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

    print('最初の通知予定日: $firstNotificationDate');

    // 2. RotationGroupを作成（rotationStartDateを最初の通知予定日に設定）
    final rotationGroupWithFirstDate = rotationGroup.copyWith(
      currentRotationIndex: 0, // 新規作成時は必ず0
      rotationStartDate: firstNotificationDate, // 最初の通知予定日を設定
      updatedAt: DateTime.now().toLocal(),
    );

    print(
      '作成用currentRotationIndex: ${rotationGroupWithFirstDate.currentRotationIndex}',
    );
    print(
      '作成用rotationStartDate: ${rotationGroupWithFirstDate.rotationStartDate}',
    );

    final rotationResult = await _rotationRepository.createRotationGroup(
      rotationGroupWithFirstDate,
    );

    return rotationResult.when(
      success: (createdGroup) async {
        try {
          print('ローテーショングループ作成完了');
          print('ID: ${createdGroup.rotationGroupId}');
          print(
            '作成されたcurrentRotationIndex: ${createdGroup.currentRotationIndex}',
          );
          print('作成されたrotationStartDate: ${createdGroup.rotationStartDate}');

          // 3. RotationNotificationsを作成（未来分のみ計算済み）
          final calculationResult = _scheduleCalculationService
              .planUpcomingNotifications(rotationGroup: createdGroup);
          if (calculationResult.isFailure) {
            throw Exception('通知計算失敗: ${calculationResult.displayText}');
          }
          final result = calculationResult.valueOrNull!;

          print('計算された通知数: ${result.notificationSettings.length}');
          print('通知作成開始...');

          // 4. 各通知を作成（すべて未来分）
          int successCount = 0;
          for (final notification in result.notificationSettings) {
            final createResult = await _notificationRepository
                .createNotification(notification);
            if (createResult.isFailure) {
              throw Exception('通知作成失敗: ${createResult.displayText}');
            }
            successCount++;
            print(
              '[$successCount/${result.notificationSettings.length}] 通知作成成功: ${notification.notificationTime} - ${notification.memberName}',
            );
          }

          // 5. RotationGroupのcurrentRotationIndexを更新
          final updatedGroup = createdGroup.copyWith(
            currentRotationIndex: result.newCurrentRotationIndex,
            lastScheduledDate:
                result.hasNotifications
                    ? result.notificationSettings.last.notificationTime
                    : createdGroup.lastScheduledDate,
          );

          print(
            'currentRotationIndex更新: ${createdGroup.currentRotationIndex} → ${updatedGroup.currentRotationIndex}',
          );

          final finalUpdateResult = await _rotationRepository
              .updateRotationGroup(updatedGroup);
          if (finalUpdateResult.isFailure) {
            throw Exception('最終更新失敗: ${finalUpdateResult.displayText}');
          }

          final finalGroup = finalUpdateResult.valueOrNull!;
          print('最終currentRotationIndex: ${finalGroup.currentRotationIndex}');
          print('最終rotationStartDate: ${finalGroup.rotationStartDate}');
          print('=== ローテーショングループ作成処理完了 ===');

          return Results.success(finalGroup);
        } catch (e) {
          // エラー時はロールバック
          print('=== エラー発生、ロールバック実行 ===');
          print('エラー内容: $e');
          await _rotationRepository.deleteRotationGroup(
            createdGroup.ownerUserId,
            createdGroup.rotationGroupId!,
          );
          print('ロールバック完了');
          return Results.failure(NotificationFailure('通知作成に失敗しました: $e'));
        }
      },
      failure: (error) {
        print('ローテーショングループ作成失敗: $error');
        return Results.failure(error);
      },
    );
  }
}
