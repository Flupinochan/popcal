import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/rotation_failure.dart';
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
    if (createRotationResult.isFailure) {
      return Results.failure(RotationFailure(createRotationResult.displayText));
    }
    final createdRotation = createRotationResult.valueOrNull!;

    // 以降、update_rotation_use_case処理と重複しているため、まとめるべき
    // 処理内容としては、ローテーション情報から通知設定する処理

    // 2. 通知設定計算 ※2の処理はsync_notifications_use_caseでも利用
    final fromDateTime = createdRotation.updatedAt.value;
    final toDateTime = fromDateTime.add(const Duration(days: 30));
    // 通知設定用データ取得
    final notificationScheduleResult = _rotationCalculationService
        .calculationNotificationSchedule(
          rotation: createdRotation,
          fromDateTime: fromDateTime,
          toDateTime: toDateTime,
        );
    if (notificationScheduleResult.isFailure) {
      return Results.failure(
        NotificationFailure(notificationScheduleResult.displayText),
      );
    }
    final notificationSchedule = notificationScheduleResult.valueOrNull!;

    // 3. 各通知を作成
    final createResults = await Future.wait(
      notificationSchedule.notificationEntries.map(
        _notificationRepository.createNotification,
      ),
    );
    for (final createNotificationResult in createResults) {
      if (createNotificationResult.isFailure) {
        return Results.failure(
          NotificationFailure(createNotificationResult.displayText),
        );
      }
    }

    // 4. RotationのcurrentRotationIndexを更新
    final updatedRotation = createdRotation.copyWith(
      currentRotationIndex: notificationSchedule.newCurrentRotationIndex,
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
  }
}
