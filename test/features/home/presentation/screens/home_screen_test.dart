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
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/notifications/use_cases/sync_notifications_use_case.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_stream.dart';

void main() {
  const screenSize = Size(411, 914);
  const mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );
  final rotations = <RotationResponse>[
    RotationResponse(
      rotationId: RotationId('test-rotation-id-1'),
      userId: const UserId('test-user-id-1'),
      rotationName: const RotationName('test-rotation-name-1'),
      rotationMembers: const RotationMemberNames([
        'tester1-1',
        'tester1-2',
      ]),
      rotationDays: [Weekday.monday, Weekday.sunday],
      notificationTime: NotificationTime(const TimeOfDay(hour: 15, minute: 0)),
      currentRotationIndex: const RotationIndex(0),
      createdAt: RotationCreatedAt(DateTime(2025, 8, 31, 9)),
      updatedAt: RotationUpdatedAt(DateTime(2025, 8, 31, 9)),
      displayDays: '月, 日',
      displayMembers: 'tester1-1, tester1-2',
      displayNotificationTime: '09:00',
      skipEvents: [],
    ),
    RotationResponse(
      rotationId: RotationId('test-rotation-id-2'),
      userId: const UserId('test-user-id-2'),
      rotationName: const RotationName('test-rotation-name-2'),
      rotationMembers: const RotationMemberNames([
        'tester2-1',
        'tester2-2',
      ]),
      rotationDays: [Weekday.monday, Weekday.sunday],
      notificationTime: NotificationTime(const TimeOfDay(hour: 16, minute: 0)),
      currentRotationIndex: const RotationIndex(0),
      createdAt: RotationCreatedAt(DateTime(2025, 9, 1, 9)),
      updatedAt: RotationUpdatedAt(DateTime(2025, 9, 1, 9)),
      displayDays: '月, 日',
      displayMembers: 'tester2-1, tester2-2',
      displayNotificationTime: '09:00',
      skipEvents: [],
    ),
  ];

  group('HomeScreen', () {
    Widget buildTestWidget(List<Override> otherOverrides) {
      final container = ProviderContainer(
        overrides: [
          notificationGatewayProvider.overrideWith((ref) {
            return MockNotificationGateway();
          }),
          authStateChangesForUIProvider.overrideWith(
            (ref) => Stream.value(Results.success(mockUser)),
          ),
          syncNotificationsUseCaseProvider.overrideWith((ref) {
            return MockSyncNotificationsUseCase();
          }),
          ...otherOverrides,
        ],
      );
      return UncontrolledProviderScope(
        container: container,
        // Scaffold Messengerを利用するにはMaterialAppでWrapが必要
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: GoldenTestScenario(
            name: 'home_screen',
            constraints: BoxConstraints.tight(screenSize),
            child: HomeScreen(),
          ),
        ),
      );
    }

    goldenTest(
      'home_screen_empty',
      fileName: 'home_screen_empty',
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
          rotationResponsesStreamProvider(mockUser.userId).overrideWith((ref) {
            return Stream.value(Results.success([]));
          }),
        ]);
      },
    );

    goldenTest(
      'home_screen',
      fileName: 'home_screen',
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
          rotationResponsesStreamProvider(mockUser.userId).overrideWith((ref) {
            return Stream.value(Results.success(rotations));
          }),
        ]);
      },
    );

    goldenTest(
      'dismissible_delete_rotation',
      fileName: 'dismissible_delete_rotation',
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
          rotationResponsesStreamProvider(mockUser.userId).overrideWith((ref) {
            return Stream.value(Results.success(rotations));
          }),
          rotationRepositoryProvider.overrideWith((ref) {
            return MockRotationRepository();
          }),
        ]);
      },
      // Golden Test前のユーザ操作
      whilePerforming: (tester) async {
        await tester.pumpAndSettle();

        // DismissibleをスライドしてRotationを削除
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
  });
}

class MockNotificationGateway extends Mock implements NotificationGateway {
  @override
  Future<Result<void>> initializeNotificationLaunch() async {
    return Results.success(null);
  }
}

class MockRotationRepository extends Mock implements RotationRepository {
  @override
  Future<Result<void>> deleteRotation(
    UserId userId,
    RotationId rotationId,
  ) async {
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
