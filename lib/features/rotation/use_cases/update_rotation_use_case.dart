import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';

class UpdateRotationUseCase {
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _scheduleCalculationService;

  UpdateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  /// 更新処理は、既存のローテーショングループを削除し、再作成
  Future<Result<Rotation>> execute(Rotation rotation) async {
    if (rotation.rotationId == null) {
      return Results.failure(ValidationFailure('ローテーショングループIDが指定されていません'));
    }

    // 1. ローテーショングループを削除
    final deleteResult = await _notificationRepository
        .deleteNotificationsByRotationId(rotation.rotationId!);
    if (deleteResult.isFailure) {
      return Results.failure(deleteResult.failureOrNull!);
    }

    // 4. ローテーショングループを再作成
    // ※メンバーの更新場所と同一箇所でindexやcreatedAtも更新しておくべき
    final updateResult = await _rotationRepository.updateRotation(rotation);
    if (updateResult.isFailure) {
      return Results.failure(updateResult.failureOrNull!);
    }
    final finalRotation = updateResult.valueOrNull!;

    // 5. 新しい通知スケジュールを計算
    final calculationResult = _scheduleCalculationService
        .planUpcomingNotifications(rotation: finalRotation);
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

    // 7. Rotationの状態を最終更新
    final finalUpdatedRotation = finalRotation.copyWith(
      currentRotationIndex: result.newCurrentRotationIndex,
    );
    final finalUpdateRotationResult = await _rotationRepository.updateRotation(
      finalUpdatedRotation,
    );
    if (finalUpdateRotationResult.isFailure) {
      return Results.failure(finalUpdateRotationResult.failureOrNull!);
    }
    final finalUpdateRotation = finalUpdateRotationResult.valueOrNull!;

    return Results.success(finalUpdateRotation);
  }
}
