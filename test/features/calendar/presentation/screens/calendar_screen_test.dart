import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/calendar/domain/enum/member_color.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:popcal/features/calendar/providers/calendar_handlers.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/shared/providers/utils_providers.dart';

void main() {
  const screenSize = Size(411, 914);
  const mockUser = UserResponse(
    userId: 'test-user-id',
    emailLocalPart: 'test',
    emailDomain: 'example.com',
  );
  const rotationId = 'test-rotation-id';
  final rotationResponse = RotationResponse(
    rotationId: rotationId,
    userId: mockUser.userId,
    rotationName: 'test-rotation-name',
    rotationMembers: [
      'user1',
      'user2',
      'user3',
      'user4',
    ],
    rotationDays: [Weekday.monday, Weekday.friday],
    notificationTime: const TimeOfDay(hour: 9, minute: 0),
    currentRotationIndex: 0,
    createdAt: DateTime(2025, 8, 14, 9),
    updatedAt: DateTime(2025, 8, 14, 9),
    skipEvents: SkipEvents([
      SkipEvent(
        dateKey: DateKey.create(DateTime(2025, 8, 20)).value,
        dayType: DayType.holiday,
        skipCount: const SkipCount(),
      ),
      SkipEvent(
        dateKey: DateKey.create(DateTime(2025, 8, 27)).value,
        dayType: DayType.skipToNext,
        skipCount: const SkipCount(skipCount: 2),
      ),
    ]),
    displayDays: '月, 金',
    displayMembers: 'user1, user2, user3, user4',
    displayNotificationTime: '09:00',
  );

  final scheduleMap = <DateKey, ScheduleDayResponse>{
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
      memberName: 'ローテーション対象外',
      scheduleDayType: DayType.holiday,
      memberColor: MemberColor.notApplicable.color,
      displayText: DayType.holiday.displayText,
      canSkipNext: false,
      canSkipPrevious: false,
      canDisableHoliday: true,
      canEnableHoliday: false,
      isValidRotationDay: false,
    ),
    DateKey.create(DateTime(2025, 8, 22)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 22, 9),
      memberName: 'user3',
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member3.color,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
    DateKey.create(DateTime(2025, 8, 25)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 25, 9),
      memberName: 'user4',
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member4.color,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
    DateKey.create(DateTime(2025, 8, 27)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 27, 9),
      memberName: 'user3',
      scheduleDayType: DayType.skipToNext,
      memberColor: MemberColor.member1.color,
      displayText: DayType.skipToNext.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
    DateKey.create(DateTime(2025, 8, 29)).value: ScheduleDayResponse(
      date: DateTime(2025, 8, 29, 9),
      memberName: 'user4',
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member2.color,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
      canDisableHoliday: false,
      canEnableHoliday: true,
      isValidRotationDay: true,
    ),
  };

  final calendarScheduleResponse = CalendarScheduleResponse(
    rotationResponse: rotationResponse,
    scheduleMap: scheduleMap,
  );

  group('CalendarScreen', () {
    Widget buildTestWidget(List<Override> otherOverrides) {
      final container = ProviderContainer(overrides: [...otherOverrides]);
      return UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: GoldenTestScenario(
            name: 'home_screen',
            constraints: BoxConstraints.tight(screenSize),
            child: const CalendarScreen(rotationId: rotationId),
          ),
        ),
      );
    }

    goldenTest(
      'calendar_screen',
      fileName: 'calendar_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder: () {
        return buildTestWidget([
          timeUtilsProvider.overrideWith((ref) => MockTimeUtilsImpl()),
          calendarScheduleResponseProvider(rotationId).overrideWith((ref) {
            return Result.ok(calendarScheduleResponse);
          }),
        ]);
      },
    );
  });
}

class MockTimeUtilsImpl extends Mock implements TimeUtils {
  @override
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  DateTime now() {
    return DateTime(2025, 8, 14, 9);
  }
}
