import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/notifications/use_cases/sync_notifications_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_stream.dart';
import 'package:popcal/router/router.dart';
import 'package:popcal/router/routes.dart';

class MockNotificationGateway extends Mock implements NotificationGateway {
  @override
  Future<Result<void>> initializeNotificationLaunch() async {
    return Results.success(null);
  }
}

class MockSyncNotificationsUseCase extends Mock
    implements SyncNotificationsUseCase {
  @override
  Future<Result<void>> execute(UserId userId) async {
    return Results.success(null);
  }
}

class MockAuthNotifier extends Mock implements AuthNotifier {}

void main() {
  final screenSize = Size(411, 914);
  final mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );

  group('Router', () {
    Widget buildTestWidget(List<Override> otherOverrides, String screen) {
      final container = ProviderContainer(
        overrides: [
          notificationGatewayProvider.overrideWith((ref) {
            return MockNotificationGateway();
          }),
          rotationResponsesStreamProvider(mockUser.userId).overrideWith((ref) {
            return Stream.value(Results.success([]));
          }),
          syncNotificationsUseCaseProvider.overrideWith((ref) {
            return MockSyncNotificationsUseCase();
          }),
          ...otherOverrides,
        ],
      );
      return UncontrolledProviderScope(
        container: container,
        child: GoldenTestScenario(
          name: 'router',
          constraints: BoxConstraints.tight(screenSize),
          child: Consumer(
            builder: (context, ref, child) {
              final router = ref.watch(routerProvider(initialLocation: screen));
              return MaterialApp.router(
                themeMode: ThemeMode.system,
                theme: AppTheme.lightTheme,
                routerConfig: router,
              );
            },
          ),
        ),
      );
    }

    goldenTest(
      'authenticated_in_login_screen',
      fileName: 'authenticated_in_login_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pump();
        await tester.pumpAndSettle();
        expect(find.byType(HomeScreen), findsOneWidget);
      },
      builder:
          // 1. 認証済かつ認証画面にいる => ホーム画面へ
          () => buildTestWidget([
            authStateChangesForUIProvider.overrideWith(
              (ref) => Stream.value(Results.success(mockUser)),
            ),
          ], Routes.auth),
    );

    goldenTest(
      'not_authenticated_in_home_screen',
      fileName: 'not_authenticated_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pump();
        await tester.pumpAndSettle();
        expect(find.byType(LoginScreen), findsOneWidget);
      },
      builder:
          // 2. 未認証かつ認証画面にいない => 認証画面へ
          () => buildTestWidget([
            authStateChangesForUIProvider.overrideWith(
              (ref) => Stream.value(Results.success(null)),
            ),
          ], Routes.home),
    );

    goldenTest(
      'authenticated_in_home_screen',
      fileName: 'authenticated_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pump();
        await tester.pumpAndSettle();
        expect(find.byType(HomeScreen), findsOneWidget);
      },
      builder:
          // 3. 認証済かつ認証画面にいない => 画面遷移しない
          () => buildTestWidget([
            authStateChangesForUIProvider.overrideWith(
              (ref) => Stream.value(Results.success(mockUser)),
            ),
          ], Routes.home),
    );

    goldenTest(
      'error_in_home_screen',
      fileName: 'error_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pump(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        expect(find.byType(LoginScreen), findsOneWidget);
      },
      builder:
          // 4. 認証エラー時に認証画面にいない => 認証画面へ
          () => buildTestWidget([
            authStateChangesForUIProvider.overrideWith(
              (ref) => Stream.value(Results.failure(AuthFailure('認証エラー'))),
            ),
          ], Routes.home),
    );
  });
}
