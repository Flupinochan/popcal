import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';

/// home画面表示時に通知設定を同期するUseCase
/// firebaseとの同期ではなく、現在時刻から30日分を計算、作成
class SyncNotificationsUseCase {
  final RotationRepository _rotationRepository;
  final NotificationGateway _notificationRepository;
  final RotationCalculationService _scheduleCalculationService;

  SyncNotificationsUseCase(
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  Future<Result<void>> execute(String ownerUserId) async {
    // 1. Firebaseからローテーショングループ一覧を取得
    final rotationsResult = await _rotationRepository.getRotations(ownerUserId);
    if (rotationsResult.isFailure) {
      return Results.failure(rotationsResult.failureOrNull!);
    }
    final rotations = rotationsResult.valueOrNull!;

    // 2. 現在設定されているローカル通知IDリストを取得
    final notificationResult = await _notificationRepository.getNotifications();
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }
    final currentLocalNotificationIds = notificationResult.valueOrNull!.toSet();

    // 3. 各ローテーショングループの通知設定を現在時刻から再計算
    String? errorMessage;
    for (final rotation in rotations) {
      // 3-1. 通知スケジュールを計算
      final calculationResult = _scheduleCalculationService
          .planUpcomingNotifications(rotation: rotation);
      if (calculationResult.isFailure) {
        errorMessage = calculationResult.failureOrNull!.message;
        continue;
      }
      final result = calculationResult.valueOrNull!;

      // 3-2. 通知作成を同期
      final createResult = await createSync(
        result,
        currentLocalNotificationIds,
        rotation,
      );
      if (createResult.isFailure) {
        errorMessage = createResult.failureOrNull!.message;
        continue;
      }

      // 3.3 通知削除を同期
      final deleteResult = await deleteSync(
        result,
        currentLocalNotificationIds,
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

  // ローカル通知の作成を同期
  Future<Result<void>> createSync(
    NotificationSchedule result,
    Set<int> currentLocalNotificationIds,
    Rotation rotation,
  ) async {
    String? errorMessage;

    // 不足しているローカル通知設定を取得
    final missingNotifications =
        result.notificationEntry.where((notification) {
          return !currentLocalNotificationIds.contains(
            notification.notificationId,
          );
        }).toList();

    // 不足分の通知を作成
    for (final notification in missingNotifications) {
      final createResult = await _notificationRepository.createNotification(
        notification,
      );
      if (createResult.isFailure) {
        errorMessage = createResult.failureOrNull!.message;
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
        errorMessage = updateResult.failureOrNull!.message;
      }
    }

    if (errorMessage != null) {
      return Results.failure(NotificationFailure(errorMessage));
    } else {
      return Results.success(null);
    }
  }

  // ローカル通知の削除を同期
  Future<Result<void>> deleteSync(
    NotificationSchedule result,
    Set<int> currentLocalNotificationIds,
  ) async {
    String? errorMessage;

    // 計算結果の通知Idsを取得
    final validNotificationIds = <int>{};
    for (final notification in result.notificationEntry) {
      validNotificationIds.add(notification.notificationId.value);
    }

    // 計算結果の通知Idsに含まれていない現在設定されている通知Idsは削除対象
    final deleteTargetIds = currentLocalNotificationIds.where(
      (id) => !validNotificationIds.contains(id),
    );

    for (final id in deleteTargetIds) {
      final result = await _notificationRepository.deleteNotification(id);
      if (result.isFailure) {
        errorMessage = result.failureOrNull!.message;
      }
    }

    if (errorMessage != null) {
      return Results.failure(NotificationFailure(errorMessage));
    } else {
      return Results.success(null);
    }
  }
}
