import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
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
    ],
    rotationDays: [
      Weekday.monday,
      Weekday.friday,
    ],
    notificationTime: const TimeOfDay(hour: 9, minute: 0),
    currentRotationIndex: 0,
    createdAt: DateTime(2025, 8, 31, 9),
    updatedAt: DateTime(2025, 8, 31, 9),
    displayDays: '月, 金',
    displayMembers: 'user1, user2',
    displayNotificationTime: '09:00',
    skipEvents: SkipEvents.empty(),
  );

  group('RotationScreen', () {
    Widget buildTestWidget(List<Override> otherOverrides) {
      final container = ProviderContainer(overrides: [...otherOverrides]);
      return UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: GoldenTestScenario(
            name: 'home_screen',
            constraints: BoxConstraints.tight(screenSize),
            child: const RotationScreen(),
          ),
        ),
      );
    }

    goldenTest(
      'create_rotation_screen',
      fileName: 'create_rotation_screen',
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
          rotationDataResponseProvider(null).overrideWith((_) {
            return Future.value(
              Results.success(const RotationDataResponse(mockUser, null)),
            );
          }),
          rotationNotifierProvider.overrideWith(MockRotationNotifier.new),
          timeUtilsProvider.overrideWith((ref) => MockTimeUtils()),
        ]);
      },
    );

    goldenTest(
      'update_rotation_screen',
      fileName: 'update_rotation_screen',
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
          rotationDataResponseProvider(null).overrideWith((_) {
            return Future.value(
              Results.success(const RotationDataResponse(mockUser, null)),
            );
          }),
          rotationNotifierProvider.overrideWith(MockRotationNotifier.new),
          timeUtilsProvider.overrideWith((ref) => MockTimeUtils()),
          rotationDataResponseProvider(null).overrideWith((ref) {
            return Future.value(
              Results.success(RotationDataResponse(mockUser, rotationResponse)),
            );
          }),
        ]);
      },
    );
  });
}

class MockRotationNotifier extends Mock implements RotationNotifier {}

class MockTimeUtils extends Mock implements TimeUtils {
  @override
  DateTime now() {
    return DateTime(2025, 8, 31, 9);
  }
}
