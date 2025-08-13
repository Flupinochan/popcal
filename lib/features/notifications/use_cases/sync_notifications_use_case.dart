import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

/// home画面表示時に通知設定を同期するUseCase
/// firebaseとの同期ではなく、現在時刻から30日分を計算、作成
class SyncNotificationsUseCase {
  SyncNotificationsUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _scheduleCalculationService;

  // ローカル通知の作成を同期
  Future<Result<void>> createSync(
    NotificationSchedule result,
    Set<NotificationId> currentLocalRotationIds,
    Rotation rotation,
  ) async {
    // 不足しているローカル通知設定を取得
    final missingNotifications =
        result.notificationEntries.where((notification) {
          return !currentLocalRotationIds.contains(notification.notificationId);
        }).toList();

    // 不足分の通知を作成
    final createResult = await Future.wait(
      missingNotifications.map(
        _notificationRepository.createNotification,
      ),
    );
    for (final createResult in createResult) {
      if (createResult.isFailure) {
        return Results.failure(NotificationFailure(createResult.displayText));
      }
    }

    // ローテーション状態を更新
    if (missingNotifications.isNotEmpty) {
      final updatedRotation = rotation.copyWith(
        currentRotationIndex: result.newCurrentRotationIndex,
      );

      final updateResult = await _rotationRepository.updateRotation(
        updatedRotation,
      );
      if (updateResult.isFailure) {
        return Results.failure(NotificationFailure(updateResult.displayText));
      }
    }

    return Results.success(null);
  }

  // ローカル通知の削除を同期
  Future<Result<void>> deleteSync(
    NotificationSchedule result,
    Set<NotificationId> currentLocalRotationIds,
  ) async {
    // 計算結果の通知Idsを取得
    final validNotificationIds =
        result.notificationEntries
            .map((notificationEntry) => notificationEntry.notificationId)
            .toSet();

    // 計算結果の通知Idsに含まれていない現在設定されている通知Idsは削除対象
    final deleteTargetIds = currentLocalRotationIds.where(
      (id) => !validNotificationIds.contains(id),
    );
    final deleteResults = await Future.wait(
      deleteTargetIds.map(
        _notificationRepository.deleteNotification,
      ),
    );
    for (final deleteResult in deleteResults) {
      if (deleteResult.isFailure) {
        return Results.failure(NotificationFailure(deleteResult.displayText));
      }
    }

    return Results.success(null);
  }

  Future<Result<void>> execute(UserId userId) async {
    // 1. Firebaseからローテーショングループ一覧を取得
    final rotationsResult = await _rotationRepository.getRotations(userId);
    if (rotationsResult.isFailure) {
      return Results.failure(rotationsResult.failureOrNull!);
    }
    final rotations = rotationsResult.valueOrNull!;

    // 2. 現在設定されているローカル通知IDリストを取得
    final notificationResult = await _notificationRepository.getNotifications();
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }
    final currentLocalRotationIds = notificationResult.valueOrNull!.toSet();

    String? errorMessage;
    for (final rotation in rotations) {
      // update_rotation_use_case処理と重複しているため、まとめるべき
      // 処理内容としては、ローテーション情報から通知設定する処理

      // 2. 通知設定計算
      final fromDateTime = rotation.updatedAt.value;
      final toDateTime = fromDateTime.add(const Duration(days: 30));
      final rotationCalculationDataResult = _scheduleCalculationService
          .calculateRotationSchedule(
            rotation: rotation,
            fromDateTime: rotation.updatedAt.value,
            toDateTime: toDateTime,
          );
      if (rotationCalculationDataResult.isFailure) {
        return Results.failure(
          NotificationFailure(rotationCalculationDataResult.displayText),
        );
      }
      final rotationCalculationData =
          rotationCalculationDataResult.valueOrNull!;

      // 通知設定用データに変換
      final notificationScheduleResult = _scheduleCalculationService
          .getNotificationEntry(
            rotation,
            rotationCalculationData,
          );
      if (notificationScheduleResult.isFailure) {
        return Results.failure(
          NotificationFailure(notificationScheduleResult.displayText),
        );
      }
      final notificationSchedule = notificationScheduleResult.valueOrNull!;

      // 3-2. 通知作成を同期
      final createResult = await createSync(
        notificationSchedule,
        currentLocalRotationIds,
        rotation,
      );
      if (createResult.isFailure) {
        errorMessage = createResult.failureOrNull!.message;
        continue;
      }

      // 3.3 通知削除を同期
      final deleteResult = await deleteSync(
        notificationSchedule,
        currentLocalRotationIds,
      );
      if (deleteResult.isFailure) {
        errorMessage = deleteResult.failureOrNull!.message;
        continue;
      }
    }
    if (errorMessage != null) {
      return Results.failure(NotificationFailure(errorMessage));
    }

    return Results.success(null);
  }
}
