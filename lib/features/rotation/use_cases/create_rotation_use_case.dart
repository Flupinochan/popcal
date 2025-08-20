import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class CreateRotationUseCase {
  CreateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._rotationCalculationService,
  );

  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _rotationCalculationService;

  Future<Result<Rotation>> execute(Rotation rotation) async {
    // 1. ローテーショングループ作成
    final createRotationResult = await _rotationRepository.createRotation(
      rotation,
    );
    if (createRotationResult.isError) {
      return Result.error(createRotationResult.error);
    }
    final createdRotation = createRotationResult.value;

    // 2. 通知設定計算
    final fromDateTime = createdRotation.updatedAt.value;
    final toDateTime = fromDateTime.add(const Duration(days: 30));
    final notificationScheduleResult = _rotationCalculationService
        .calculationNotificationSchedule(
          rotation: createdRotation,
          fromDateTime: fromDateTime,
          toDateTime: toDateTime,
        );
    if (notificationScheduleResult.isError) {
      return Result.error(notificationScheduleResult.error);
    }
    final notificationSchedule = notificationScheduleResult.value;

    // 3. 各通知を作成
    final createResults = await Future.wait(
      notificationSchedule.notificationEntries.map(
        _notificationRepository.createNotification,
      ),
    );
    for (final createNotificationResult in createResults) {
      if (createNotificationResult.isError) {
        return Result.error(createNotificationResult.error);
      }
    }

    // 4. RotationIndexを更新
    final updatedRotation = createdRotation.copyWith(
      currentRotationIndex: notificationSchedule.newCurrentRotationIndex,
    );
    final updatedRotationResult = await _rotationRepository.updateRotation(
      updatedRotation,
    );
    if (updatedRotationResult.isError) {
      return Result.error(updatedRotationResult.error);
    }
    final finalRotation = updatedRotationResult.value;
    return Result.ok(finalRotation);
  }
}
