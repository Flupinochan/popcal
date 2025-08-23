import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/time_utils.dart';

class MockTimeUtils extends Mock implements TimeUtils {
  @override
  DateTime now() {
    return DateTime(2025, 8, 31, 9);
  }
}
