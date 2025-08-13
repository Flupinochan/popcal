import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/entities/skip_event.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/skip_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class RotationCalculationServiceImpl implements RotationCalculationService {
  RotationCalculationServiceImpl(this._timeUtils);
  final TimeUtils _timeUtils;

  /// 1. 次回の通知予定日を計算
  @override
  Result<DateTime> findNextRotationDate({
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  }) {
    // 曜日指定のローテーション機能であり、遅くても未来7日後までに最初の通知日があるはず
    // 判定開始日は+0日で、今から未来+8日分をチェックが妥当だが
    // 拡張性を考え未来1年分(+365)は計算可能にする ※whileはリスクがあるため利用しない
    for (
      var checkDate = rotationDateTime.dateTime;
      checkDate.isBefore(
        rotationDateTime.dateTime.add(const Duration(days: 365)),
      );
      checkDate = checkDate.add(const Duration(days: 1))
    ) {
      // 日付のみに変換
      final dateKey = DateKey.fromDateTime(checkDate);

      if (isValidNotificationDate(
        checkDate: dateKey,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
        skipEvents: skipEvents,
      )) {
        return Results.success(checkDate);
      }
    }
    return Results.failure(const ValidationFailure('次回ローテーション日の取得に失敗しました'));
  }

  @override
  ScheduleDayType getScheduleDayType({
    required DateKey checkDate,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  }) {
    final checkDay = Weekday.fromDateTime(checkDate.value);

    // ローテーション曜日でない場合
    if (!rotationDays.contains(checkDay)) {
      return ScheduleDayType.notRotationDay;
    }

    // holiday skip日の場合
    final hasHolidaySkip = skipEvents.any(
      (event) => event.date == checkDate && event.type == SkipType.holiday,
    );
    if (hasHolidaySkip) {
      return ScheduleDayType.holiday;
    }

    // 時刻チェック
    final notificationDateTime = NotificationDateTime.fromDateAndTime(
      date: checkDate,
      notificationTime: notificationTime,
    );
    if (notificationDateTime.isAfterRotationDateTime(rotationDateTime)) {
      return ScheduleDayType.rotationDay;
    }

    // 過去の時刻の場合は対象外
    return ScheduleDayType.notRotationDay;
  }

  /// ローテーション日判定
  @override
  bool isValidNotificationDate({
    required DateKey checkDate,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationDateTime rotationDateTime,
    required List<SkipEvent> skipEvents,
  }) {
    final checkDay = Weekday.fromDateTime(checkDate.value);

    // ローテーション曜日の場合
    if (rotationDays.contains(checkDay)) {
      // holiday skip日の場合
      final hasHolidaySkip = skipEvents.any(
        (event) => event.date == checkDate && event.type == SkipType.holiday,
      );
      if (hasHolidaySkip) {
        return false;
      }

      final notificationDateTime = NotificationDateTime.fromDateAndTime(
        date: checkDate,
        notificationTime: notificationTime,
      );
      // ※作成日がローテーション曜日の場合でも、すでに時刻が過ぎている場合は、ローテーション日に含めない
      // そのため、曜日だけでなく時刻を含めて比較
      if (notificationDateTime.isAfterRotationDateTime(rotationDateTime)) {
        return true;
      }
    }
    return false;
  }

  /// 3. 通知設定用スケジュールを計算 ※実際に設定するのは30日分
  @override
  Result<NotificationSchedule> planUpcomingNotifications({
    required Rotation rotation,
    int futureDays = 30,
  }) {
    try {
      // 現在時刻をベース
      final currentTime = _timeUtils.now();
      final toDate = currentTime.add(Duration(days: futureDays));

      final notifications = <NotificationEntry>[];
      var newCurrentRotationIndex = rotation.currentRotationIndex;

      // 指定期間をループして通知情報を作成
      for (
        var checkDate = currentTime;
        checkDate.isBefore(toDate);
        checkDate = checkDate.add(const Duration(days: 1))
      ) {
        // 日付のみに変換
        final dateKey = DateKey.fromDateTime(checkDate);

        if (isValidNotificationDate(
          checkDate: dateKey,
          rotationDays: rotation.rotationDays,
          notificationTime: rotation.notificationTime,
          rotationDateTime: RotationDateTime.updatedAt(rotation.updatedAt),
          skipEvents: rotation.skipEvents,
        )) {
          final memberName = rotation.getRotationMemberName(
            newCurrentRotationIndex,
          );
          final notificationId = NotificationId.create(
            rotation.rotationId!,
            checkDate,
          );
          final notificationTime = rotation.notificationTime.value;
          final scheduledDateTime = DateTime(
            checkDate.year,
            checkDate.month,
            checkDate.day,
            notificationTime.hour,
            notificationTime.minute,
          );

          final notificationSetting = NotificationEntry(
            notificationId: notificationId,
            rotationId: rotation.rotationId!,
            userId: rotation.userId,
            rotationName: rotation.rotationName,
            notificationDate: NotificationDateTime(scheduledDateTime),
            memberName: memberName,
          );

          notifications.add(notificationSetting);
          newCurrentRotationIndex = newCurrentRotationIndex.increment();
        }
      }

      return Results.success(
        NotificationSchedule(
          notificationEntry: notifications,
          newCurrentRotationIndex: newCurrentRotationIndex,
        ),
      );
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知予定の作成に失敗しました: $error'));
    }
  }
}
