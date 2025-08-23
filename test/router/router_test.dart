// ignore_for_file: prefer-moving-to-variable

import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/utils/exceptions/auth_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_handlers.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_handlers.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';

import '../fixtures/dto/mock_rotation_response.dart';
import '../fixtures/dto/mock_user_response.dart';
import '../fixtures/gateways/mock_notification_gateway.dart';
import '../fixtures/repository/mock_rotation_repository.dart';
import '../fixtures/use_case/mock_sync_notifications_use_case.dart';
import '../fixtures/value_objects/mock_user_id.dart';
import '../helpers/golden_test_helper.dart';

void main() {
  group('Router', () {
    final overrides = [
      notificationGatewayProvider.overrideWith((ref) {
        return MockNotificationGateway();
      }),
      syncNotificationsUseCaseProvider.overrideWith((ref) {
        return MockSyncNotificationsUseCase();
      }),
      rotationRepositoryProvider.overrideWith((ref) {
        return MockRotationRepository();
      }),
      rotationResponsesStreamProvider(MockUserId.userId.value).overrideWith((
        ref,
      ) {
        return Stream.value(
          Result.ok([
            MockRotationResponse.rotationResponse1,
            MockRotationResponse.rotationResponse2,
          ]),
        );
      }),
    ];

    /// 1. 認証済かつ認証画面にいる => ホーム画面へ
    createGoldenTest(
      testName: 'authenticated_in_login_screen',
      renderScreen: HomeScreen(),
      findScreen: HomeScreen,
      overrideRiverPod: [
        ...overrides,
        authStateChangesProvider.overrideWith(
          (ref) => Stream.value(Result.ok(MockUserResponse.userResponse)),
        ),
      ],
      useRouting: true,
      initialLocation: const LoginRoute().location,
    );

    /// 2. 未認証かつ認証画面にいない => 認証画面へ
    createGoldenTest(
      testName: 'not_authenticated_in_home_screen',
      renderScreen: const LoginScreen(),
      findScreen: LoginScreen,
      overrideRiverPod: [
        ...overrides,
        authStateChangesProvider.overrideWith(
          (ref) => Stream.value(const Result.ok(null)),
        ),
      ],
      useRouting: true,
      initialLocation: const HomeRoute().location,
    );

    /// 3. 認証済かつ認証画面にいない => 画面遷移しない
    createGoldenTest(
      testName: 'authenticated_in_home_screen',
      renderScreen: HomeScreen(),
      findScreen: HomeScreen,
      overrideRiverPod: [
        ...overrides,
        authStateChangesProvider.overrideWith(
          (ref) => Stream.value(Result.ok(MockUserResponse.userResponse)),
        ),
      ],
      useRouting: true,
      initialLocation: const HomeRoute().location,
    );

    /// 4. 認証エラー時に認証画面にいない => 認証画面へ
    createGoldenTest(
      testName: 'error_in_home_screen',
      renderScreen: const LoginScreen(),
      findScreen: LoginScreen,
      overrideRiverPod: [
        ...overrides,
        authStateChangesProvider.overrideWith(
          (ref) => Stream.value(const Result.error(AuthException('認証エラー'))),
        ),
      ],
      useRouting: true,
      initialLocation: const HomeRoute().location,
    );
  });
}
