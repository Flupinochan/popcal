import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/time_utils.dart';

class MockTimeUtils extends Mock implements TimeUtils {
  @override
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  DateTime now() {
    return DateTime(2025, 8, 31, 9);
  }
}
