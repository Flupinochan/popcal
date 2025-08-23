import 'package:popcal/features/calendar/domain/enum/member_color.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';

import '../entities/mock_rotation.dart';

class MockCalendarScheduleResponse {
  static final Map<DateKey, ScheduleDayResponse> scheduleMap = {
    DateKey.create(DateTime(2025, 8, 15)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 15, 9),
      memberName: 'user1',
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member1.color,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
    DateKey.create(DateTime(2025, 8, 18)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 18, 9),
      memberName: 'user2',
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member2.color,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
    DateKey.create(DateTime(2025, 8, 20)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 20, 9),
      memberName: 'user3',
      scheduleDayType: DayType.holiday,
      memberColor: MemberColor.notApplicable.color,
      displayText: DayType.holiday.displayText,
      canSkipNext: false,
      canSkipPrevious: false,
      canDisableHoliday: true,
      canEnableHoliday: false,
      isValidRotationDay: false,
    ),
  };

  static final CalendarScheduleResponse calendarScheduleResponse =
      CalendarScheduleResponse(
        rotationResponse: RotationResponse.fromEntity(MockRotation.rotation1),
        scheduleMap: scheduleMap,
      );
}
