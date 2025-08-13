import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/skip_type.dart';
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
