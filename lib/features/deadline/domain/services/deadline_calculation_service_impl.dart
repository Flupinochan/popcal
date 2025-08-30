import 'package:holiday_jp/holiday_jp.dart' as holiday_jp;
import 'package:logging/logging.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/deadline/domain/services/deadline_calculation_service.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_content.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_description.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_title.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

class DeadlineCalculationServiceImpl implements DeadlineCalculationService {
  DeadlineCalculationServiceImpl(this._logger);

  final Logger _logger;

  @override
  Result<List<NotificationSetting>> calculationDeadlineSchedule({
    required Deadline deadline,
  }) {
    final notificationEntries = <NotificationSetting>[];
    final now = DateTime.now().toUtc();

    // 12か月分ループ
    for (var i = 0; i < 12; i++) {
      var targetYear = now.year;
      var targetMonth = now.month + i;

      // 月が12を超えた場合の年の調整
      while (targetMonth > 12) {
        targetMonth -= 12;
        targetYear++;
      }

      // 最終平日を取得
      final lastWeekdays = _getLastWeekDaysOfMonth(
        targetYear,
        targetMonth,
      );

      // 過去の日付の場合はスキップ
      // 例えば8/31(日)で設定すると8月から計算され、8月の最終平日はすでに過ぎているため
      final today = DateTime.utc(now.year, now.month, now.day);
      final lastWeekdaysUtc = DateTime.utc(
        lastWeekdays.year,
        lastWeekdays.month,
        lastWeekdays.day,
      );
      if (lastWeekdaysUtc.isBefore(today)) {
        continue;
      }

      final month = lastWeekdays.month;
      final title = NotificationTitle.createDeadline();
      final contentResult = NotificationContent.createForDeadline(month);
      if (contentResult.isError) {
        return Result.error(contentResult.error);
      }
      final content = contentResult.value;
      final descriptionResult = NotificationDescription.createForDeadline(
        month,
      );
      final description = descriptionResult.value;
      final sourceId = GroupId.createDeadlineId();
      final notificationId = NotificationId.create(
        sourceId,
        lastWeekdays,
      );

      final dateKeyResult = DateKey.create(lastWeekdays);
      if (dateKeyResult.isError) {
        return Result.error(dateKeyResult.error);
      }
      final notificationDateTime =
          NotificationDateTime.fromDateKeyAndNotificationTime(
            date: dateKeyResult.value,
            notificationTime: deadline.notificationTime,
          );

      final notificationEntry = NotificationSetting(
        notificationId: notificationId,
        groupId: sourceId,
        notificationDateTime: notificationDateTime,
        title: title,
        content: content,
        description: description,
      );

      notificationEntries.add(notificationEntry);

      // ログ出力
      final message =
          '$month月: ${notificationDateTime.getDisplayDeadline()} 通知を作成';
      _logger.fine(message);
    }

    return Result.ok(notificationEntries);
  }

  DateTime _getLastWeekDaysOfMonth(int year, int month) {
    // 来月の1日から-1日ずつして土日祝日でない平日を探す
    // Documentを参考にUTCで計算
    var lastDay = DateTime.utc(year, month + 1, 0);
    while (lastDay.weekday > 5 || holiday_jp.isHoliday(lastDay)) {
      lastDay = lastDay.subtract(const Duration(days: 1));
    }

    return lastDay.toLocal();
  }
}
