import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';

// モック ※デフォルトでは全てエラーがスローされる
class MockAuthNotifier extends Mock implements AuthNotifier {}

void main() {
  // WidgetでRiverPodのref.watch()を使用している場合はモックする必要がある
  late MockAuthNotifier mockNotifier;
  setUp(() async {
    mockNotifier = MockAuthNotifier();
    when(() => mockNotifier.state).thenReturn(const AsyncData(null));

    // await loadNotoSansJPFonts();
  });

  testWidgets('Welcome to Popcal が表示される', (tester) async {
    // 画面サイズ設定
    await tester.binding.setSurfaceSize(Size(411, 914));

    await tester.pumpWidget(
      // RiverPodのscopeをmockでoverride
      ProviderScope(
        overrides: [authNotifierProvider.overrideWith(() => mockNotifier)],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // アニメーション完了待機
    await tester.pumpAndSettle();

    // Golden Test
    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('goldens/login_screen.png'),
    );
  });
}

Future<void> loadNotoSansJPFonts() async {
  final fontLoader = FontLoader('NotoSansJP');

  final weights = [
    'Thin',
    'ExtraLight',
    'Light',
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
    'ExtraBold',
    'Black',
  ];

  for (final weight in weights) {
    final fontData = await rootBundle.load(
      'assets/fonts/noto_sans_jp/NotoSansJP-$weight.ttf',
    );
    fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));
  }

  await fontLoader.load();
}
