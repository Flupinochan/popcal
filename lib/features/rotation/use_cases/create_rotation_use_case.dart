import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';

class CreateRotationUseCase {
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _scheduleCalculationService;

  CreateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  Future<Result<Rotation>> execute(Rotation rotation) async {
    // 1. ローテーショングループ作成
    final createRotationResult = await _rotationRepository.createRotation(
      rotation,
    );
    if (createRotationResult.isFailure) {
      return Results.failure(RotationFailure(createRotationResult.displayText));
    }
    return createRotationResult.when(
      success: (rotation) async {
        // 2. 通知設定計算
        final calculationResult = _scheduleCalculationService
            .planUpcomingNotifications(rotation: rotation);
        if (calculationResult.isFailure) {
          return Results.failure(
            NotificationFailure(calculationResult.displayText),
          );
        }
        final notificationPlan = calculationResult.valueOrNull!;

        // 3. 各通知を作成
        for (final notification in notificationPlan.notificationEntry) {
          final createNotificationResult = await _notificationRepository
              .createNotification(notification);
          if (createNotificationResult.isFailure) {
            return Results.failure<Rotation>(
              NotificationFailure(createNotificationResult.displayText),
            );
          }
        }

        // 4. RotationのcurrentRotationIndexを更新
        final updatedRotation = rotation.copyWith(
          currentRotationIndex: notificationPlan.newCurrentRotationIndex,
        );
        final updatedRotationResult = await _rotationRepository.updateRotation(
          updatedRotation,
        );
        if (updatedRotationResult.isFailure) {
          return Results.failure(
            RotationFailure(updatedRotationResult.displayText),
          );
        }
        final finalRotation = updatedRotationResult.valueOrNull!;
        return Results.success(finalRotation);
      },
      failure: (error) {
        return Results.failure(RotationFailure('ローテーショングループ作成失敗: $error'));
      },
    );
  }
}
