import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/providers/auth_handlers.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_handlers.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';

import '../../../../fixtures/dto/mock_rotation_response.dart';
import '../../../../fixtures/dto/mock_user_response.dart';
import '../../../../fixtures/value_objects/mock_user_id.dart';
import '../../../../helpers/golden_test_helper.dart';
import '../../../../router/router_test.dart';
import '../../../rotation/infrastructure/repository/mock_rotation_repository.dart';

void main() {
  group('HomeScreen', () {
    final userId = MockUserId.userId.value;

    final overrides = [
      notificationGatewayProvider.overrideWith((ref) {
        return MockNotificationGateway();
      }),
      authStateChangesProvider.overrideWith(
        (ref) => Stream.value(Result.ok(MockUserResponse.userResponse)),
      ),
      syncNotificationsUseCaseProvider.overrideWith((ref) {
        return MockSyncNotificationsUseCase();
      }),
      rotationRepositoryProvider.overrideWith((ref) {
        return MockRotationRepository();
      }),
    ];

    final emptyOverride = rotationResponsesStreamProvider(userId).overrideWith((
      ref,
    ) {
      return Stream.value(const Result.ok([]));
    });

    final existOverride = rotationResponsesStreamProvider(userId).overrideWith((
      ref,
    ) {
      return Stream.value(
        Result.ok([
          MockRotationResponse.rotationResponse1,
          MockRotationResponse.rotationResponse2,
        ]),
      );
    });

    createGoldenTest(
      testName: 'empty',
      renderScreen: HomeScreen(),
      findScreen: HomeScreen,
      overrideRiverPod: [...overrides, emptyOverride],
    );

    createGoldenTest(
      testName: 'exist',
      renderScreen: HomeScreen(),
      findScreen: HomeScreen,
      overrideRiverPod: [...overrides, existOverride],
    );

    createGoldenTest(
      testName: 'delete',
      renderScreen: HomeScreen(),
      findScreen: HomeScreen,
      overrideRiverPod: [...overrides, existOverride],
      whilePerforming: (tester) async {
        // DismissibleスライドしてRotationを削除
        final dismissible = find.byType(Dismissible).first;
        expect(dismissible, findsOneWidget);
        await tester.drag(dismissible, const Offset(500, 0));
        await tester.pumpAndSettle();

        // SnackBarの存在確認
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('元に戻す'), findsOneWidget);

        return;
      },
    );

    // restoreのテスト (ref.listenがトリガー) は難しいため未実装
  });
}
