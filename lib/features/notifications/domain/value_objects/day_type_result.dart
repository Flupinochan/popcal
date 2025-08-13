import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

/// getScheduleDayTypeメソッドの返却値
class DayTypeResult {
  const DayTypeResult({
    required this.dayType,
    this.skipEvent,
  });
  // 判定した日付のタイプ
  final DayType dayType;
  // スキップ日付の場合は、SkipEventも返却
  final SkipEvent? skipEvent;
}
