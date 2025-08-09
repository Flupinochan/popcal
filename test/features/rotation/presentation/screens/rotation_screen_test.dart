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
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class MockRotationNotifier extends Mock implements RotationNotifier {}

class MockTimeUtilsImpl extends Mock implements TimeUtils {
  @override
  DateTime now() {
    return DateTime(2025, 8, 31, 9, 0);
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
    createdAt: RotationCreatedAt(DateTime(2025, 8, 31, 9, 0)),
    updatedAt: RotationUpdatedAt(DateTime(2025, 8, 31, 9, 0)),
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
            child: RotationScreen(),
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
              Results.success(RotationDataResponse(mockUser, null)),
            );
          }),
          rotationNotifierProvider.overrideWith(() => MockRotationNotifier()),
          timeUtilsProvider.overrideWith((ref) => MockTimeUtilsImpl()),
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
              Results.success(RotationDataResponse(mockUser, null)),
            );
          }),
          rotationNotifierProvider.overrideWith(() => MockRotationNotifier()),
          timeUtilsProvider.overrideWith((ref) => MockTimeUtilsImpl()),
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
