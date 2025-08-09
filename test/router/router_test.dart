import 'package:alchemist/alchemist.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/firebase_options.dart';
import 'package:popcal/router/router.dart';

void main() {
  final screenSize = Size(411, 914);
  final mockUser = UserResponse(
    userId: UserId('test-user-id'),
    email: Email('test@example.com'),
  );
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  group('Router', () {
    Widget buildTestWidget({
      required Widget widget,
      required List<Override> overrides,
    }) {
      final container = ProviderContainer(overrides: overrides);
      return UncontrolledProviderScope(
        container: container,
        child: GoldenTestScenario(
          name: 'router',
          constraints: BoxConstraints.tight(screenSize),
          child: Consumer(
            builder: (context, ref, child) {
              final router = ref.read(routerProvider);
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
      'routing_error_in_home_screen',
      fileName: 'routing_error_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder:
          () => buildTestWidget(
            // 認証エラーでHomeScreenにいる場合はLoginScreenに遷移
            widget: HomeScreen(),
            overrides: [
              firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
              authStateChangesForUIProvider.overrideWith(
                (ref) => Stream.value(Results.failure(AuthFailure('認証エラー'))),
              ),
            ],
          ),
    );

    goldenTest(
      'routing_not_authenticated_in_home_screen',
      fileName: 'routing_not_authenticated_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder:
          () => buildTestWidget(
            // 未認証時でHomeScreenにいる場合はLoginScreenに遷移
            widget: HomeScreen(),
            overrides: [
              firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
              authStateChangesForUIProvider.overrideWith(
                (ref) => Stream.value(Results.success(null)),
              ),
            ],
          ),
    );

    goldenTest(
      'routing_authenticated_in_login_screen',
      fileName: 'routing_authenticated_in_login_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder:
          () => buildTestWidget(
            // 認証済でLoginScreenにいる場合はHomeScreenに遷移
            widget: LoginScreen(),
            overrides: [
              firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
              authStateChangesForUIProvider.overrideWith(
                (ref) => Stream.value(Results.success(mockUser)),
              ),
            ],
          ),
    );

    goldenTest(
      'routing_authenticated_in_home_screen',
      fileName: 'routing_authenticated_in_home_screen',
      pumpBeforeTest: (tester) async {
        await tester.binding.setSurfaceSize(screenSize);
        await tester.pumpAndSettle();
      },
      pumpWidget: (tester, builder) async {
        await tester.pumpWidget(builder);
        await tester.pumpAndSettle();
      },
      builder:
          () => buildTestWidget(
            // 認証済でHomeScreenにいる場合は遷移しない
            widget: HomeScreen(),
            overrides: [
              firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
              authStateChangesForUIProvider.overrideWith(
                (ref) => Stream.value(Results.success(mockUser)),
              ),
            ],
          ),
    );
  });
}
