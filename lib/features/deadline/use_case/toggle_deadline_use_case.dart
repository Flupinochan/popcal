import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/deadline/domain/repositories/deadline_repository.dart';
import 'package:popcal/features/deadline/domain/services/deadline_calculation_service.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

class ToggleDeadlineUseCase {
  ToggleDeadlineUseCase(
    this._deadlineRepository,
    this._deadlineCalculationService,
    this._notificationGateway,
  );

  final DeadlineRepository _deadlineRepository;
  final DeadlineCalculationService _deadlineCalculationService;
  final NotificationGateway _notificationGateway;

  Future<Result<Deadline>> execute(Deadline deadline) async {
    // 1. 設定on/offの保存
    final settingsResult = await _deadlineRepository.saveSettings(deadline);
    if (settingsResult.isError) {
      return Result.error(settingsResult.error);
    }

    // 2-1. on時 通知登録
    if (deadline.isEnabled) {
      // 通知スケジュール計算
      final calculateResult = _deadlineCalculationService
          .calculationDeadlineSchedule(deadline: deadline);
      if (calculateResult.isError) {
        return Result.error(calculateResult.error);
      }
      final notificationEntries = calculateResult.value;

      // 各通知作成
      final createResults = await Future.wait(
        notificationEntries.map(
          _notificationGateway.createNotification,
        ),
      );
      for (final createNotificationResult in createResults) {
        if (createNotificationResult.isError) {
          return Result.error(createNotificationResult.error);
        }
      }

      return Result.ok(deadline);
    }

    // 2-2. off時 通知削除
    final sourceId = GroupId.createDeadlineId();
    final deleteResult = await _notificationGateway
        .deleteNotificationsBySourceId(sourceId);
    if (deleteResult.isError) {
      return Result.error(deleteResult.error);
    }
    return Result.ok(deadline);
  }
}
