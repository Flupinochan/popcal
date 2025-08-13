import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/entities/notification_schedule.dart';
import 'package:popcal/features/notifications/domain/value_objects/day_type_result.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/rotation_calculation_data.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

/// 2. 計算ロジックDomain Service
abstract class RotationCalculationService {
  /// 通知設定およびカレンダー表示用の共通ローテーション計算処理
  /// ※Rotation Entityのみを利用しているため、Rotation Entity内に移動すべき?
  /// [rotation] 計算対象
  /// [fromDateTime] 計算開始日付 ※通知設定の場合は更新日(現在時刻)
  /// カレンダー表示の場合はRotation作成日
  /// [toDateTime] 計算終了日付 ※通知設定の場合はfromDateから+30日分、
  /// カレンダー表示の場合はfromDateから+1年分
  Result<RotationCalculationData> calculateRotationSchedule({
    required Rotation rotation,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });

  /// calculateRotationSchedule の結果から通知設定用データに整形
  Result<NotificationSchedule> getNotificationEntry(
    Rotation rotation,
    RotationCalculationData rotationCalculationData,
  );

  /// 対象日付の曜日タイプ判定
  /// [fromDateTime] 計算開始日時
  /// [notificationDateTime] 通知日時 ※判定対象
  /// [rotationDays] ローテーション曜日
  /// [skipEvents] スキップ日リスト
  DayTypeResult getScheduleDayType({
    required DateTime fromDateTime,
    required NotificationDateTime notificationDateTime,
    required List<Weekday> rotationDays,
    required List<SkipEvent> skipEvents,
  });

  /// calculateRotationSchedule の結果からカレンダー画面表示用データに整形
  Result<Map<DateKey, ScheduleDay>> getScheduleMap(
    Rotation rotation,
    RotationCalculationData rotationCalculationData,
  );
}
