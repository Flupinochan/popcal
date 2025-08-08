import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';

class MockAuthNotifier extends Mock implements AuthNotifier {}

void main() {
  late MockAuthNotifier mockNotifier;
  setUp(() async {
    mockNotifier = MockAuthNotifier();
    when(() => mockNotifier.state).thenReturn(const AsyncData(null));
  });

  final screenSize = Size(411, 914);
  final testScreen = HomeScreen();

  testWidgets('LoginScreen1', (tester) async {
    await tester.binding.setSurfaceSize(screenSize);
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authNotifierProvider.overrideWith(() => mockNotifier)],
        child: MaterialApp(theme: AppTheme.lightTheme, home: testScreen),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('goldens/login_screen1.png'),
    );
  });

  goldenTest(
    'LoginScreen2',
    fileName: 'login_screen2',
    pumpBeforeTest: (tester) async {
      await tester.binding.setSurfaceSize(screenSize);
      await tester.pumpAndSettle();
    },
    pumpWidget: (tester, builder) async {
      await tester.pumpWidget(builder);
      await tester.pumpAndSettle();
    },
    builder: () {
      return ProviderScope(
        // ignore: scoped_providers_should_specify_dependencies
        overrides: [authNotifierProvider.overrideWith(() => mockNotifier)],
        child: GoldenTestScenario(
          name: 'LoginScreen2',
          constraints: BoxConstraints.tight(screenSize),
          child: testScreen,
        ),
      );
    },
  );
}
