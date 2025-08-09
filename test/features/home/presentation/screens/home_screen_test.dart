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
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/notifications/use_cases/sync_notifications_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_stream.dart';

class MockSyncNotificationsUseCase extends Mock
    implements SyncNotificationsUseCase {}

void main() {
  group('HomeScreen', () {
    final screenSize = Size(411, 914);
    final testScreen = HomeScreen();
    final mockUser = UserResponse(
      userId: UserId('test-user-id'),
      email: Email('test@example.com'),
    );
    // RiverPodのmock
    final container = ProviderContainer(
      overrides: [
        authStateChangesForUIProvider.overrideWith(
          (ref) => Stream.value(Results.success(mockUser)),
        ),
        rotationResponsesStreamProvider(mockUser.userId.value).overrideWith((
          ref,
        ) {
          return Stream.value(Results.success([]));
        }),
        syncNotificationsUseCaseProvider.overrideWith((ref) {
          return MockSyncNotificationsUseCase();
        }),
      ],
    );
    final testWidget = UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: AppTheme.lightTheme, home: testScreen),
    );

    testWidgets('home_screen_empty1', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(screenSize);
      await tester.pumpAndSettle();
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(HomeScreen),
        matchesGoldenFile('goldens/home_screen_empty1.png'),
      );
    });

    goldenTest(
      'home_screen_empty2',
      fileName: 'home_screen_empty2',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder: () {
        return testWidget;
      },
    );
  });
}
