import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class UpdateRotationUseCase {
  UpdateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._rotationCalculationService,
  );
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _rotationCalculationService;

  Future<Result<Rotation>> execute(Rotation rotation) async {
    // 1. 通知設定を削除
    final sourceIdResult = GroupId.createFromRotationId(rotation.rotationId!);
    if (sourceIdResult.isError) {
      return Result.error(sourceIdResult.error);
    }

    final deleteResult = await _notificationRepository
        .deleteNotificationsBySourceId(sourceIdResult.value);
    if (deleteResult.isError) {
      return Result.error(deleteResult.error);
    }

    // 2. 通知設定計算
    final fromDateTime = rotation.updatedAt.value;
    // 30日は環境設定に移す
    final toDateTime = fromDateTime.add(const Duration(days: 30));
    final notificationScheduleResult = _rotationCalculationService
        .calculationNotificationSchedule(
          rotation: rotation,
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
    final updatedRotation = rotation.copyWith(
      currentRotationIndex: notificationSchedule.newCurrentRotationIndex,
    );
    final updatedRotationNewIndexResult = await _rotationRepository
        .updateRotation(
          updatedRotation,
        );
    if (updatedRotationNewIndexResult.isError) {
      return Result.error(updatedRotationNewIndexResult.error);
    }
    final finalRotation = updatedRotationNewIndexResult.value;

    return Result.ok(finalRotation);
  }
}
