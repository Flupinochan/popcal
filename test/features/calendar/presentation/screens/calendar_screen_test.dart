import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/member_color.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class MockTimeUtilsImpl extends Mock implements TimeUtils {
  @override
  DateTime now() {
    return DateTime(2025, 8, 29, 9, 0);
  }
}

void main() {
  final screenSize = Size(411, 914);
  final mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );
  final rotationId = RotationId('test-rotation-id');
  final rotationResponse = RotationResponse(
    rotationId: rotationId,
    userId: mockUser.userId,
    rotationName: RotationName('test-rotation-name'),
    rotationMembers: [RotationMemberName('user1'), RotationMemberName('user2')],
    rotationDays: [Weekday.monday, Weekday.friday],
    notificationTime: NotificationTime(TimeOfDay(hour: 9, minute: 0)),
    currentRotationIndex: RotationIndex(0),
    createdAt: RotationCreatedAt(DateTime(2025, 8, 29, 9, 0)),
    updatedAt: RotationUpdatedAt(DateTime(2025, 8, 29, 9, 0)),
  );
  Map<DateKey, ScheduleDayResponse> scheduleMap = {
    DateKey.fromDateTime(DateTime(2025, 8, 29)): ScheduleDayResponse(
      date: NotificationDateTime(DateTime(2025, 8, 29, 9, 0)),
      memberName: RotationMemberName('user1'),
      isRotationDay: true,
      memberColor: MemberColor.member1,
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
