import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_group_dto.dart';

class UpdateRotationGroupUseCase {
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;
  final ScheduleCalculationService _scheduleCalculationService;

  UpdateRotationGroupUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  /// 更新処理は、既存のローテーショングループを削除し、再作成
  Future<Result<RotationGroup>> execute(UpdateRotationGroupDto dto) async {
    // 1. 更新対象のローテーショングループ情報を取得
    final existingResult = await _rotationRepository.getRotationGroup(
      dto.userId,
      dto.rotationGroupId,
    );
    if (existingResult.isFailure) {
      return Results.failure(existingResult.failureOrNull!);
    }

    // 2. Entityへ変換
    final existingEntity = existingResult.valueOrNull;
    if (existingEntity == null) {
      return Results.failure(ValidationFailure('ローテーショングループが見つかりませんでした'));
    }

    // 3. ローテーショングループを削除
    final deleteResult = await _notificationRepository
        .deleteNotificationsByRotationGroupId(existingEntity.rotationGroupId!);
    if (deleteResult.isFailure) {
      return Results.failure(deleteResult.failureOrNull!);
    }

    // 4. ローテーショングループを再作成
    // ※メンバーの更新場所と同一箇所でindexやcreatedAtも更新しておくべき
    final updatedEntityResult = dto.applyToEntity(existingEntity);
    if (updatedEntityResult.isFailure) {
      return Results.failure(updatedEntityResult.failureOrNull!);
    }
    final updatedRotationGroup = updatedEntityResult.valueOrNull!;

    final updateResult = await _rotationRepository.updateRotationGroup(
      updatedRotationGroup,
    );
    if (updateResult.isFailure) {
      return Results.failure(updateResult.failureOrNull!);
    }
    final finalGroup = updateResult.valueOrNull!;

    // 5. 新しい通知スケジュールを計算
    final calculationResult = _scheduleCalculationService
        .planUpcomingNotifications(rotationGroup: finalGroup);
    if (calculationResult.isFailure) {
      return Results.failure(calculationResult.failureOrNull!);
    }
    final result = calculationResult.valueOrNull!;

    // 6. 新しい通知を作成
    for (final notification in result.notificationSettings) {
      final createResult = await _notificationRepository.createNotification(
        notification,
      );
      if (createResult.isFailure) {
        return Results.failure(createResult.failureOrNull!);
      }
    }

    // 7. RotationGroupの状態を最終更新
    final finalUpdatedGroup = finalGroup.copyWith(
      currentRotationIndex: result.newCurrentRotationIndex,
    );
    final finalUpdateResult = await _rotationRepository.updateRotationGroup(
      finalUpdatedGroup,
    );
    if (finalUpdateResult.isFailure) {
      return Results.failure(finalUpdateResult.failureOrNull!);
    }
    final finalRotationGroup = finalUpdateResult.valueOrNull!;

    return Results.success(finalRotationGroup);
  }
}
