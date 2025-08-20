import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

/// home画面表示時に通知設定を同期するUseCase
/// firebaseとの同期ではない
/// アプリを起動するたびに現在時刻から30日分を計算、作成することで常に1か月分の通知設定をし続ける
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
      if (createResult.isError) {
        return Result.error(createResult.error);
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
      if (updateResult.isError) {
        return Result.error(updateResult.error);
      }
    }

    return const Result.ok(null);
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
      if (deleteResult.isError) {
        return Result.error(deleteResult.error);
      }
    }

    return const Result.ok(null);
  }

  // メイン処理
  Future<Result<void>> execute(UserId userId) async {
    // 1. Firebaseからローテーショングループ一覧を取得
    final rotationsResult = await _rotationRepository.getRotations(userId);
    if (rotationsResult.isError) {
      return Result.error(rotationsResult.error);
    }
    final rotations = rotationsResult.value;

    // 2. 現在設定されているローカル通知IDリストを取得
    final notificationResult = await _notificationRepository.getNotifications();
    if (notificationResult.isError) {
      return Result.error(notificationResult.error);
    }
    final currentLocalRotationIds = notificationResult.value.toSet();

    Exception? exception;
    for (final rotation in rotations) {
      // update_rotation_use_case処理と重複しているため、まとめるべき
      // 処理内容としては、ローテーション情報から通知設定する処理

      // 3. 通知設定計算
      final fromDateTime = rotation.updatedAt.value;
      final toDateTime = fromDateTime.add(const Duration(days: 30));
      final notificationScheduleResult = _scheduleCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: rotation.updatedAt.value,
            toDateTime: toDateTime,
          );
      if (notificationScheduleResult.isError) {
        return Result.error(notificationScheduleResult.error);
      }
      final notificationSchedule = notificationScheduleResult.value;

      // 4. 通知作成を同期
      final createResult = await createSync(
        notificationSchedule,
        currentLocalRotationIds,
        rotation,
      );
      if (createResult.isError) {
        exception = createResult.error;
        continue;
      }

      // 5. 通知削除を同期
      final deleteResult = await deleteSync(
        notificationSchedule,
        currentLocalRotationIds,
      );
      if (deleteResult.isError) {
        exception = deleteResult.error;
        continue;
      }
    }

    if (exception != null) {
      return Result.error(exception);
    }

    return const Result.ok(null);
  }
}
