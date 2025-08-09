import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/result.dart';
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
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/features/rotation/providers/rotation_stream.dart';

class MockNotificationGateway extends Mock implements NotificationGateway {
  @override
  Future<Result<void>> initializeNotificationLaunch() async {
    return Results.success(null);
  }
}

class MockSyncNotificationsUseCase extends Mock
    implements SyncNotificationsUseCase {
  @override
  Future<Result<void>> execute(String ownerUserId) async {
    return Results.success(null);
  }
}

class MockRotationRepository extends Mock implements RotationRepository {
  @override
  Future<Result<void>> deleteRotation(String userId, String rotationId) async {
    return Results.success(null);
  }
}

class MockRotationNotifier extends Mock implements RotationNotifier {
  @override
  Future<Result<RotationResponse>> createRotation(
    CreateRotationRequest dto,
  ) async {
    final rotation = RotationResponse(
      rotationId: RotationId('test-rotation-id'),
      userId: UserId('test-user-id'),
      rotationName: RotationName('test-rotation-name'),
      rotationMembers: [],
      rotationDays: [],
      notificationTime: NotificationTime.now(),
      currentRotationIndex: RotationIndex(0),
      createdAt: RotationCreatedAt(DateTime.now()),
      updatedAt: RotationUpdatedAt(DateTime.now()),
    );
    return Results.success(rotation);
  }
}

void main() {
  final screenSize = Size(411, 914);
  final mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );

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
        child: GoldenTestScenario(
          name: 'home_screen',
          constraints: BoxConstraints.tight(screenSize),
          child: HomeScreen(),
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
          rotationResponsesStreamProvider(mockUser.userId.value).overrideWith((
            ref,
          ) {
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
        List<RotationResponse> rotations = [
          RotationResponse(
            rotationId: RotationId('test-rotation-id-1'),
            userId: UserId('test-user-id-1'),
            rotationName: RotationName('test-rotation-name-1'),
            rotationMembers: [
              RotationMemberName('tester1-1'),
              RotationMemberName('tester1-2'),
            ],
            rotationDays: [Weekday.monday, Weekday.sunday],
            notificationTime: NotificationTime.now(),
            currentRotationIndex: RotationIndex(0),
            createdAt: RotationCreatedAt(DateTime.now()),
            updatedAt: RotationUpdatedAt(DateTime.now()),
          ),
          RotationResponse(
            rotationId: RotationId('test-rotation-id-2'),
            userId: UserId('test-user-id-2'),
            rotationName: RotationName('test-rotation-name-2'),
            rotationMembers: [
              RotationMemberName('tester2-1'),
              RotationMemberName('tester2-2'),
            ],
            rotationDays: [Weekday.monday, Weekday.sunday],
            notificationTime: NotificationTime.now(),
            currentRotationIndex: RotationIndex(0),
            createdAt: RotationCreatedAt(DateTime.now()),
            updatedAt: RotationUpdatedAt(DateTime.now()),
          ),
        ];

        return buildTestWidget([
          rotationResponsesStreamProvider(mockUser.userId.value).overrideWith((
            ref,
          ) {
            return Stream.value(Results.success(rotations));
          }),
        ]);
      },
    );
  });
}
