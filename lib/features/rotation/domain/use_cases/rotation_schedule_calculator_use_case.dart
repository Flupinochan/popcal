import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_notification.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_calculation_result.dart';

/// 各通知設定計算用UseCase
class RotationScheduleCalculatorUseCase {
  /// 30日分の通知設定Listを作成
  Result<RotationCalculationResult> createNotifications({
    required RotationGroup rotationGroup,
    int daysAhead = 30,
  }) {
    try {
      if (rotationGroup.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未初期化です'));
      }

      final now = DateTime.now().toLocal();
      final endDate = now.add(Duration(days: daysAhead));

      final result = _generateNotifications(
        rotationGroup: rotationGroup,
        startDate: now,
        endDate: endDate,
      );

      return Results.success(result);
    } catch (e) {
      return Results.failure(NetworkFailure('通知の作成に失敗しました: $e'));
    }
  }

  RotationCalculationResult _generateNotifications({
    required RotationGroup rotationGroup,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final notifications = <RotationNotification>[];
    var currentIndex = rotationGroup.currentRotationIndex;

    // 30日分をループ
    for (
      var date = startDate; // 開始日
      date.isBefore(endDate.add(const Duration(days: 1))); // 終了日
      date = date.add(const Duration(days: 1)) // +1日
    ) {
      // 曜日を取得
      final weekday = Weekday.fromDateTime(date);

      // 曜日がローテーション曜日か判定
      if (rotationGroup.rotationDays.contains(weekday)) {
        final memberIndex = currentIndex % rotationGroup.rotationMembers.length;
        final memberName = rotationGroup.rotationMembers[memberIndex];

        final notificationTime = DateTime(
          date.year,
          date.month,
          date.day,
          rotationGroup.notificationTime.hour,
          rotationGroup.notificationTime.minute,
        );

        final notificationId = _generateNotificationId(
          rotationGroup.rotationGroupId!,
          date,
        );

        final notification = RotationNotification(
          notificationId: notificationId,
          rotationGroupId: rotationGroup.rotationGroupId!,
          ownerUserId: rotationGroup.ownerUserId,
          rotationName: rotationGroup.rotationName,
          notificationTime: notificationTime,
          memberName: memberName,
          createdAt: DateTime.now().toLocal(),
        );

        notifications.add(notification);
        currentIndex++;
      }
    }

    return RotationCalculationResult(
      notifications: notifications,
      newCurrentRotationIndex: currentIndex,
    );
  }

  /// 通知ID生成
  int _generateNotificationId(String rotationGroupId, DateTime date) {
    // 🔥 日時情報をIDに埋め込む（yyyyMMdd形式）
    final dateInt = date.year * 10000 + date.month * 100 + date.day;
    return dateInt;
  }
}
