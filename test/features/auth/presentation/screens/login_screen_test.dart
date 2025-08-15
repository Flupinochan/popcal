import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';

void main() {
  group('LoginScreen', () {
    // すべてのtestWidgetsで1度だけ初期化
    const screenSize = Size(411, 914);
    const testScreen = LoginScreen();

    // WidgetでRiverPodのref.watch()を使用している場合はモックする必要がある
    late MockAuthNotifier mockNotifier;

    // setUpはtestWidgetsごとに初期化される
    // testWidgetsごとに初期状態にしたい場合、可変な変数を定義する場合に利用
    setUp(() async {
      mockNotifier = MockAuthNotifier();
    });

    testWidgets('login_screen1', (tester) async {
      // 画面サイズ設定
      await tester.binding.setSurfaceSize(screenSize);
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        // RiverPodのscopeをmockでoverride
        ProviderScope(
          overrides: [authNotifierProvider.overrideWith(() => mockNotifier)],
          child: MaterialApp(theme: AppTheme.lightTheme, home: testScreen),
        ),
      );
      // アニメーション完了待機
      await tester.pumpAndSettle();
      // Golden Test
      await expectLater(
        find.byType(LoginScreen),
        matchesGoldenFile('goldens/login_screen1.png'),
      );
    });

    goldenTest(
      'login_screen2',
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
            name: 'login_screen2',
            constraints: BoxConstraints.tight(screenSize),
            child: testScreen,
          ),
        );
      },
    );
  });
}

// モック ※デフォルトでは全てエラーがスローされる
class MockAuthNotifier extends Mock implements AuthNotifier {}
