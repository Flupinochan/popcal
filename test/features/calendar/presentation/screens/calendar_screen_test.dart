import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:popcal/features/calendar/providers/calendar_handlers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';

import '../../../../fixtures/dto/mock_calendar_schedule_response.dart';
import '../../../../fixtures/utils/mock_time_utils.dart';
import '../../../../fixtures/value_objects/mock_rotation_id.dart';
import '../../../../helpers/golden_test_helper.dart';

void main() {
  group('CalendarScreen', () {
    final rotationId = MockRotationId.rotationId.value;

    final overrides = [
      timeUtilsProvider.overrideWith((ref) => MockTimeUtils()),
      calendarScheduleResponseProvider(rotationId).overrideWith((
        ref,
      ) {
        return Result.ok(MockCalendarScheduleResponse.calendarScheduleResponse);
      }),
    ];

    createGoldenTest(
      testName: 'exist',
      renderScreen: CalendarScreen(rotationId: rotationId),
      findScreen: CalendarScreen,
      overrideRiverPod: [...overrides],
    );
  });
}
