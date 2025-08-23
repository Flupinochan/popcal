import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/core/themes/app_theme.dart';
import 'package:popcal/router/router.dart';

/// GoldenTestをする際に利用
void createGoldenTest<T extends Widget>({
  required String testName,
  required T renderScreen,
  required Type findScreen,
  required List<Override> overrideRiverPod,
  Future<Future<void> Function()?> Function(WidgetTester)? whilePerforming,
  bool useRouting = false,
  String? initialLocation,
}) {
  const screenSize = Size(411, 914);
  final themeData = AppTheme.lightTheme;

  goldenTest(
    testName,
    fileName: testName,
    pumpBeforeTest: (tester) async {
      await tester.binding.setSurfaceSize(screenSize);
    },
    pumpWidget: (tester, builder) async {
      await tester.pumpWidget(builder);
      await tester.pumpAndSettle();
      expect(find.byType(findScreen), findsOneWidget);
    },
    whilePerforming: whilePerforming,
    builder: () {
      if (useRouting && initialLocation == null) {
        throw Exception('Routingが有効にもかかわらず、initialLocationが設定されていません');
      }

      return UncontrolledProviderScope(
        container: ProviderContainer(
          overrides: overrideRiverPod,
        ),
        child: GoldenTestScenario(
          name: testName,
          constraints: BoxConstraints.tight(screenSize),
          // 実機デバイスをまねるために、MediaQueryのpaddingを設定
          child: MediaQuery(
            data: const MediaQueryData(
              size: screenSize,
              padding: EdgeInsets.symmetric(vertical: 30),
              devicePixelRatio: 3,
            ),
            child:
                useRouting
                    ? Consumer(
                      builder: (context, ref, child) {
                        final router = ref.watch(
                          routerProvider(initialLocation: initialLocation!),
                        );

                        return MaterialApp.router(
                          theme: themeData,
                          routerConfig: router,
                        );
                      },
                    )
                    : MaterialApp(
                      theme: themeData,
                      home: renderScreen,
                    ),
          ),
        ),
      );
    },
  );
}
