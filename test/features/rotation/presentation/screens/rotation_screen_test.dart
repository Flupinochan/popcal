import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/providers/auth_handlers.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/features/rotation/providers/rotation_handlers.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';

import '../../../../fixtures/dto/mock_rotation_data_response.dart';
import '../../../../fixtures/dto/mock_user_response.dart';
import '../../../../fixtures/providers/mock_rotation_notifier.dart';
import '../../../../fixtures/repository/mock_rotation_repository.dart';
import '../../../../fixtures/utils/mock_time_utils.dart';
import '../../../../fixtures/value_objects/mock_rotation_id.dart';
import '../../../../helpers/golden_test_helper.dart';

void main() {
  final rotationId = MockRotationId.rotationId.value;

  final overrides = [
    authStateChangesProvider.overrideWith(
      (ref) => Stream.value(Result.ok(MockUserResponse.userResponse)),
    ),
    rotationRepositoryProvider.overrideWith((ref) {
      return MockRotationRepository();
    }),
    rotationNotifierProvider.overrideWith(MockRotationNotifier.new),
    timeUtilsProvider.overrideWith((ref) => MockTimeUtils()),
  ];

  group('RotationScreen', () {
    createGoldenTest(
      testName: 'create',
      renderScreen: const RotationScreen(),
      findScreen: RotationScreen,
      overrideRiverPod: [
        ...overrides,
        rotationDataResponseProvider(null).overrideWith((_) {
          return Future.value(
            Result.ok(
              RotationDataResponse(MockUserResponse.userResponse, null),
            ),
          );
        }),
      ],
    );

    createGoldenTest(
      testName: 'update',
      renderScreen: RotationScreen(rotationId: rotationId),
      findScreen: RotationScreen,
      overrideRiverPod: [
        ...overrides,
        rotationDataResponseProvider(rotationId).overrideWith((_) {
          return Future.value(
            Result.ok(MockRotationDataResponse.rotationDataResponse),
          );
        }),
      ],
    );
  });
}
