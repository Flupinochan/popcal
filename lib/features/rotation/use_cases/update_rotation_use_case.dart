import 'package:popcal/core/utils/exceptions/rotation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

class UpdateRotationUseCase {
  UpdateRotationUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._rotationCalculationService,
  );
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _rotationCalculationService;

  Future<Result<Rotation>> execute({
    required UserId userId,
    required RotationId rotationId,
    required RotationName updateRotationName,
    required RotationMemberNames updateRotationMemberNames,
    required RotationDays updateRotationDays,
    required NotificationTime updateNotificationTime,
    required SkipEvents updateSkipEvents,
    required RotationUpdatedAt rotationUpdatedAt,
  }) async {
    // 1. 既存のRotation情報を取得
    final existingRotationResult = await _rotationRepository.getRotation(
      userId,
      rotationId,
    );
    if (existingRotationResult.isError) {
      return Result.error(existingRotationResult.error);
    }
    final existingRotation = existingRotationResult.value;
    if (existingRotation == null) {
      return const Result.error(RotationException('Update対象のRotationが存在しません'));
    }

    // 2. 既存の通知設定を削除
    final sourceIdResult = GroupId.createFromRotationId(
      existingRotation.rotationId!,
    );
    if (sourceIdResult.isError) {
      return Result.error(sourceIdResult.error);
    }

    final deleteResult = await _notificationRepository
        .deleteNotificationsBySourceId(sourceIdResult.value);
    if (deleteResult.isError) {
      return Result.error(deleteResult.error);
    }

    // 3. RotationにUpdateするフィールドが含まれているかチェック
    final hasUpdateField = existingRotation.hasUpdateField(
      updateRotationName: updateRotationName,
      updateRotationMemberNames: updateRotationMemberNames,
      updateRotationDays: updateRotationDays,
      updateNotificationTime: updateNotificationTime,
      updateSkipEvents: updateSkipEvents,
    );
    if (!hasUpdateField) {
      return const Result.error(
        RotationException('ローテーション情報の更新において、更新フィールドが1つもありません'),
      );
    }

    // 4. UpdateしたRotation Entityを作成
    final updatedRotation = existingRotation.copyWith(
      rotationName: updateRotationName,
      rotationMemberNames: updateRotationMemberNames,
      rotationDays: updateRotationDays,
      notificationTime: updateNotificationTime,
      skipEvents: updateSkipEvents,
      updatedAt: rotationUpdatedAt,
    );

    // 5. 通知設定を計算
    final fromDateTime = updatedRotation.updatedAt.value;
    // 30日は環境設定に移す
    final toDateTime = fromDateTime.add(const Duration(days: 30));
    final notificationScheduleResult = _rotationCalculationService
        .calculationNotificationSchedule(
          rotation: updatedRotation,
          fromDateTime: fromDateTime,
          toDateTime: toDateTime,
        );
    if (notificationScheduleResult.isError) {
      return Result.error(notificationScheduleResult.error);
    }
    final notificationSchedule = notificationScheduleResult.value;

    // 6. 各通知を作成
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

    // 7. RotationIndexを更新し、FirebaseのRotationを更新
    final updatedRotationOfIndex = updatedRotation.copyWith(
      currentRotationIndex: notificationSchedule.newCurrentRotationIndex,
    );
    final updatedRotationNewIndexResult = await _rotationRepository
        .updateRotation(
          updatedRotationOfIndex,
        );
    if (updatedRotationNewIndexResult.isError) {
      return Result.error(updatedRotationNewIndexResult.error);
    }
    final finalRotation = updatedRotationNewIndexResult.value;

    return Result.ok(finalRotation);
  }
}
