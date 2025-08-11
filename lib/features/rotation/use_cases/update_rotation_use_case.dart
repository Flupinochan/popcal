import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class UpdateRotationUseCase {
  UpdateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _scheduleCalculationService;

  /// 更新処理は、既存のローテーショングループを削除し、再作成
  Future<Result<Rotation>> execute(Rotation rotation) async {
    if (rotation.rotationId == null) {
      return Results.failure(
        const ValidationFailure('ローテーショングループIDが指定されていません'),
      );
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
    final createResults = await Future.wait(
      result.notificationEntry.map(
        _notificationRepository.createNotification,
      ),
    );
    for (final createResult in createResults) {
      if (createResult.isFailure) {
        return Results.failure(NotificationFailure(createResult.displayText));
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
