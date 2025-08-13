import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';

class SkipEvent {
  const SkipEvent({
    required this.date,
    required this.type,
    required this.skipCount,
  });

  final DateKey date;
  final SkipType type;
  final SkipCount skipCount;
}

enum SkipType {
  nextMember, // 次の人に回す場合、ローテーション日に変わりはない
  holiday, // 休日などでローテーション日にしたくない場合、ローテーション日から除外
}
