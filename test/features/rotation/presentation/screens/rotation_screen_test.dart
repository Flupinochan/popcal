import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/providers/core_provider.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';

class MockRotationNotifier extends Mock implements RotationNotifier {}

void main() {
  final screenSize = Size(411, 914);
  final mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
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
          nowProvider.overrideWith((ref) => DateTime(2025, 8, 31, 9, 0)),
        ]);
      },
    );
  });
}
