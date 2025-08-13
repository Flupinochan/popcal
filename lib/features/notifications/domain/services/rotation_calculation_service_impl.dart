import 'package:collection/collection.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/day_calculation_data.dart';
import 'package:popcal/features/notifications/domain/value_objects/day_type_result.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/rotation_calculation_data.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class RotationCalculationServiceImpl implements RotationCalculationService {
  RotationCalculationServiceImpl(this._timeUtils);
  final TimeUtils _timeUtils;

  @override
  Result<RotationCalculationData> calculateRotationSchedule({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) {
    try {
      final dayCalculationResults = <DayCalculationData>[];
      var newRotationIndex = rotation.currentRotationIndex.value;

      // fromDateからtoDateまで+1日しながらfor文で計算
      for (
        var checkDateTime = fromDateTime;
        checkDateTime.isBefore(toDateTime);
        checkDateTime = checkDateTime.add(const Duration(days: 1))
      ) {
        // ローテーション日(checkDateTime)と通知時刻(notificationTime)から
        // NotificationDateTime(通知日時)を生成
        final dateKey = DateKey.fromDateTime(checkDateTime);
        final notificationTime = rotation.notificationTime;
        final notificationDateTime = NotificationDateTime.fromDateAndTime(
          date: dateKey,
          notificationTime: notificationTime,
        );

        // タイプ判定
        final dayTypeResult = getScheduleDayType(
          fromDateTime: fromDateTime,
          notificationDateTime: notificationDateTime,
          rotationDays: rotation.rotationDays,
          skipEvents: rotation.skipEvents,
        );
        final dayType = dayTypeResult.dayType;
        final skipEvent = dayTypeResult.skipEvent;

        final memberIndex = rotation.getRotationMemberIndex(
          RotationIndex(newRotationIndex),
        );

        switch (dayType) {
          // ローテーション日でない場合は担当者を示すmemberIndexをnull
          case DayType.holiday:
          case DayType.notRotationDay:
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: null,
                dayType: dayType,
              ),
            );
          // ローテーション日の場合はシンプルにnewRotationIndexを+1
          case DayType.rotationDay:
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: memberIndex,
                dayType: dayType,
              ),
            );
            newRotationIndex++;
          // 次の人にスキップするローテーション日の場合は、
          // skipCount分indexを進めたmemberIndexを取得
          // 1つスキップする場合は、skipCountは1
          case DayType.skipToNext:
            newRotationIndex += skipEvent!.skipCount.skipCount;
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: memberIndex,
                dayType: dayType,
              ),
            );
            newRotationIndex++;
          // 前の人に戻すローテーション日の場合は、
          // skipCountから-1したmemberIndexを取得
          // 2つスキップする予定から1つスキップに変える場合 (2 - 1)
          // ※1つスキップの場合はありえない。UIでSkipEventを削除して再計算するため
          case DayType.skipToPrevious:
            newRotationIndex += skipEvent!.skipCount.skipCount - 1;
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: memberIndex,
                dayType: dayType,
              ),
            );
            newRotationIndex++;
        }
      }

      return Results.success(
        RotationCalculationData(
          dayCalculationDatas: dayCalculationResults,
          newRotationIndex: newRotationIndex,
        ),
      );
    } on Exception catch (error) {
      return Results.failure(NotificationFailure('通知計算処理でエラーが発生: $error'));
    }
  }

  @override
  Result<NotificationSchedule> getNotificationEntry(
    Rotation rotation,
    RotationCalculationData rotationCalculationData,
  ) {
    try {
      final notificationEntries = <NotificationEntry>[];
      for (final dayCalculationData
          in rotationCalculationData.dayCalculationDatas) {
        final memberIndex = dayCalculationData.memberIndex;
        final notificationDateTime = dayCalculationData.notificationDateTime;

        // memberIndexがない場合は、通知日でないためcontinue
        if (memberIndex == null) {
          continue;
        }

        notificationEntries.add(
          NotificationEntry(
            notificationId: NotificationId.create(
              rotation.rotationId!,
              notificationDateTime.value,
            ),
            rotationId: rotation.rotationId!,
            userId: rotation.userId,
            rotationName: rotation.rotationName,
            notificationDateTime: notificationDateTime,
            memberName: rotation.rotationMemberNames[memberIndex],
          ),
        );
      }

      return Results.success(
        NotificationSchedule(
          notificationEntries: notificationEntries,
          newCurrentRotationIndex: RotationIndex(
            rotationCalculationData.newRotationIndex,
          ),
        ),
      );
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('通知設定用データ整形処理でエラーが発生: $error'),
      );
    }
  }

  @override
  DayTypeResult getScheduleDayType({
    required DateTime fromDateTime,
    required NotificationDateTime notificationDateTime,
    required List<Weekday> rotationDays,
    required List<SkipEvent> skipEvents,
  }) {
    final checkDay = Weekday.fromDateTime(notificationDateTime.value);

    // 1. ローテーション曜日でない場合
    if (!rotationDays.contains(checkDay)) {
      return const DayTypeResult(dayType: DayType.notRotationDay);
    }

    // 2. 過去の時刻の場合
    if (notificationDateTime.isBeforeDateTime(fromDateTime)) {
      return const DayTypeResult(dayType: DayType.notRotationDay);
    }

    // 3. Skip日かどうか
    final skipEvent = skipEvents.firstWhereOrNull(
      (event) => _timeUtils.isSameDateKeyWithNotificationDateTime(
        event.dateKey,
        notificationDateTime,
      ),
    );

    if (skipEvent == null) {
      return const DayTypeResult(dayType: DayType.rotationDay);
    }

    switch (skipEvent.dayType) {
      case DayType.skipToNext:
        return DayTypeResult(
          dayType: DayType.skipToNext,
          skipEvent: skipEvent,
        );
      case DayType.skipToPrevious:
        return DayTypeResult(
          dayType: DayType.skipToPrevious,
          skipEvent: skipEvent,
        );
      case DayType.holiday:
        return DayTypeResult(
          dayType: DayType.holiday,
          skipEvent: skipEvent,
        );
      // 以下2つのDayTypeはバリデーションにより、ありえないがswitchの仕様により定義
      case DayType.notRotationDay:
        return const DayTypeResult(dayType: DayType.notRotationDay);
      case DayType.rotationDay:
        return const DayTypeResult(dayType: DayType.rotationDay);
    }
  }

  @override
  Result<Map<DateKey, ScheduleDay>> getScheduleMap(
    Rotation rotation,
    RotationCalculationData rotationCalculationData,
  ) {
    try {
      final scheduleMap = <DateKey, ScheduleDay>{};
      for (final dayCalculationData
          in rotationCalculationData.dayCalculationDatas) {
        final memberIndex = dayCalculationData.memberIndex;
        final dayType = dayCalculationData.dayType;
        final notificationDateTime = dayCalculationData.notificationDateTime;

        final dateKey = DateKey.fromDateTime(
          dayCalculationData.notificationDateTime.value,
        );

        final scheduleDay = ScheduleDay(
          date: notificationDateTime,
          memberName:
              memberIndex != null
                  ? rotation.rotationMemberNames[memberIndex]
                  : RotationMemberName.notApplicable,
          scheduleType: dayType,
          memberColor: MemberColor.fromIndex(memberIndex),
        );
        scheduleMap[dateKey] = scheduleDay;
      }
      return Results.success(scheduleMap);
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('カレンダー画面表示用データ整形処理でエラーが発生: $error'),
      );
    }
  }

  // ログ出力
  void _printNotifications(List<NotificationEntry> notificationEntry) {
    for (final notification in notificationEntry) {
      print(
        '通知予定: ${notification.notificationDateTime.value} ${notification.memberName}',
      );
    }
  }
}
