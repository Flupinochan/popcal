import 'package:collection/collection.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/services/result/day_calculation_data.dart';
import 'package:popcal/features/notifications/domain/services/result/day_type_result.dart';
import 'package:popcal/features/notifications/domain/services/result/rotation_calculation_data.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
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
  Result<NotificationSchedule> calculationNotificationSchedule({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) {
    // 共通の計算処理
    final rotationCalculationDataResult = _calculateRotationSchedule(
      rotation: rotation,
      fromDateTime: fromDateTime,
      toDateTime: toDateTime,
    );
    if (rotationCalculationDataResult.isFailure) {
      return Results.failure(
        RotationFailure(rotationCalculationDataResult.displayText),
      );
    }
    final rotationCalculationData = rotationCalculationDataResult.valueOrNull!;

    // 通知設定用データに整形
    try {
      if (rotation.rotationId == null) {
        return Results.failure(
          const NotificationFailure('ローテーションIDがnullです。'),
        );
      }

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
            memberName: rotation.rotationMemberNames.memberAt(memberIndex),
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
  Result<Map<DateKey, ScheduleDay>> calculationScheduleMap({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) {
    // 共通の計算処理
    final rotationCalculationDataResult = _calculateRotationSchedule(
      rotation: rotation,
      fromDateTime: fromDateTime,
      toDateTime: toDateTime,
    );
    if (rotationCalculationDataResult.isFailure) {
      return Results.failure(
        RotationFailure(rotationCalculationDataResult.displayText),
      );
    }
    final rotationCalculationData = rotationCalculationDataResult.valueOrNull!;

    // カレンダー画面表示用データに整形
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
                  ? rotation.rotationMemberNames.memberAt(memberIndex)
                  : RotationMemberName.notApplicable,
          scheduleType: dayType,
          memberColor: MemberColor.fromIndex(memberIndex),
          canSkipNext: rotation.canSkipNext(dateKey: dateKey, dayType: dayType),
          canSkipPrevious: rotation.canSkipPrevious(
            dateKey: dateKey,
            dayType: dayType,
          ),
          canDisableHoliday: rotation.canDisableHoliday(dayType: dayType),
          canEnableHoliday: rotation.canEnableHoliday(dayType: dayType),
          isValidRotationDay: rotation.isValidRotationDay(dayType: dayType),
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

  /// 通知設定およびカレンダー表示用の共通ローテーション計算処理
  /// [rotation] 計算対象
  /// [fromDateTime] 計算開始日付
  /// 通知設定の場合は更新日(現在時刻)
  /// カレンダー表示の場合はRotation作成日
  /// [toDateTime] 計算終了日付
  /// 通知設定の場合はfromDateから+30日分、
  /// カレンダー表示の場合はfromDateから+1年分
  Result<RotationCalculationData> _calculateRotationSchedule({
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
        final dayTypeResult = _getScheduleDayType(
          fromDateTime: fromDateTime,
          notificationDateTime: notificationDateTime,
          rotationDays: rotation.rotationDays,
          skipEvents: rotation.skipEvents,
        );
        final dayType = dayTypeResult.dayType;
        final skipEvent = dayTypeResult.skipEvent;

        switch (dayType) {
          // ローテーション日でない場合は担当者を示すmemberIndexをnull
          // ★データを軽くするために、DayType.notRotationDayは返却しない
          // そしてUI(Dto)側で存在しない日についてはnotRotationDayとして扱う
          case DayType.holiday:
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: null,
                dayType: dayType,
              ),
            );
          // ローテーション日の場合はシンプルにnewRotationIndexを+1
          case DayType.rotationDay:
            final memberIndex = rotation.getRotationMemberIndex(
              RotationIndex(newRotationIndex),
            );
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
          // 1つスキップする場合は、skipCountが1
          // 2つスキップする場合は、skipCountが2
          case DayType.skipToNext:
            newRotationIndex += skipEvent!.skipCount.skipCount;
            final memberIndex = rotation.getRotationMemberIndex(
              RotationIndex(newRotationIndex),
            );
            dayCalculationResults.add(
              DayCalculationData(
                notificationDateTime: notificationDateTime,
                memberIndex: memberIndex,
                dayType: dayType,
              ),
            );
            newRotationIndex++;
          // 前の人に戻すローテーション日の場合は、存在しない
          // 前の人に戻す場合は、skipToNextでskipCountを減らして再計算するため

          // ローテーションに関係のない日(すべての日)を計算結果に含めるとデータが重いため、含めないことにする
          // CalendarScheduleResponse (dto) 側で見つからないデータをnotRotationDayと判定する
          case DayType.notRotationDay:
            break;
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

  /// 対象日付のタイプ判定
  /// [fromDateTime] 計算開始日時
  /// [notificationDateTime] 対象日付
  /// [rotationDays] ローテーション曜日
  /// [skipEvents] スキップ日リスト
  DayTypeResult _getScheduleDayType({
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

    // Skip日の場合はskipEventも返却
    switch (skipEvent.dayType) {
      case DayType.skipToNext:
        return DayTypeResult(
          dayType: DayType.skipToNext,
          skipEvent: skipEvent,
        );
      case DayType.holiday:
        return DayTypeResult(
          dayType: DayType.holiday,
          skipEvent: skipEvent,
        );
      // 以下2つのDayTypeはバリデーションにより、ありえないがswitchの仕様により定義
      // ignore: no_default_cases
      default:
        throw Exception('予期しないDayTypeに判定されました: ${skipEvent.dayType}');
    }
  }

  // ログ出力
  // ignore: unused_element
  void _printNotifications(List<NotificationEntry> notificationEntry) {
    for (final notification in notificationEntry) {
      print(
        '通知予定: ${notification.notificationDateTime.value} ${notification.memberName}',
      );
    }
  }
}
