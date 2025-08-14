import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/time_utils.dart';

void main() {
  const screenSize = Size(411, 914);
  const mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );
  final rotationId = RotationId('test-rotation-id');
  final rotationResponse = RotationResponse(
    rotationId: rotationId,
    userId: mockUser.userId,
    rotationName: RotationName('test-rotation-name'),
    rotationMembers: [
      const RotationMemberName('user1'),
      const RotationMemberName('user2'),
      const RotationMemberName('user3'),
      const RotationMemberName('user4'),
    ],
    rotationDays: [Weekday.monday, Weekday.friday],
    notificationTime: NotificationTime(const TimeOfDay(hour: 9, minute: 0)),
    currentRotationIndex: const RotationIndex(0),
    createdAt: RotationCreatedAt(DateTime(2025, 8, 14, 9)),
    updatedAt: RotationUpdatedAt(DateTime(2025, 8, 14, 9)),
    // 20日をholiday skip
    skipEvents: [
      SkipEvent(
        dateKey: DateKey.fromDateTime(DateTime(2025, 8, 20)),
        dayType: DayType.holiday,
        skipCount: const SkipCount(skipCount: 1),
      ),
    ],
    displayDays: '月, 金',
    displayMembers: 'user1, user2, user3, user4',
    displayNotificationTime: '09:00',
  );
  final scheduleMap = <DateKey, ScheduleDayResponse>{
    // 15日: user1 (index 0)
    DateKey.fromDateTime(DateTime(2025, 8, 15)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 15, 9)),
      memberName: const RotationMemberName('user1'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member1,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
    ),
    // 18日: user2 (index 1)
    DateKey.fromDateTime(DateTime(2025, 8, 18)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 18, 9)),
      memberName: const RotationMemberName('user2'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member2,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
    ),
    // 20日休日
    DateKey.fromDateTime(DateTime(2025, 8, 20)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 20, 9)),
      memberName: RotationMemberName.notApplicable,
      scheduleDayType: DayType.holiday,
      memberColor: MemberColor.notApplicable,
      displayText: DayType.holiday.displayText,
      canSkipNext: false,
      canSkipPrevious: false,
    ),
    // 22日: user3 (index 2)
    DateKey.fromDateTime(DateTime(2025, 8, 22)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 22, 9)),
      memberName: const RotationMemberName('user3'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member3,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
    ),
    // 25日: user4 (index 3)
    DateKey.fromDateTime(DateTime(2025, 8, 25)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 25, 9)),
      memberName: const RotationMemberName('user4'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member4,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
    ),
    // 27日: user1 (index 0に戻る)
    DateKey.fromDateTime(DateTime(2025, 8, 27)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 27, 9)),
      memberName: const RotationMemberName('user1'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member1,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
    ),
    // 29日: user2 (index 1)
    DateKey.fromDateTime(DateTime(2025, 8, 29)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 29, 9)),
      memberName: const RotationMemberName('user2'),
      scheduleDayType: DayType.rotationDay,
      memberColor: MemberColor.member2,
      displayText: DayType.rotationDay.displayText,
      canSkipNext: true,
      canSkipPrevious: false,
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
            child: CalendarScreen(rotationId: rotationId),
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
            return Results.success(calendarScheduleResponse);
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
