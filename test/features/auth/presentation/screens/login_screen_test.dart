import 'package:flutter_test/flutter_test.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';

import '../../../../helpers/golden_test_helper.dart';
import '../../providers/mock_auth_notifier.dart';

void main() {
  group('LoginScreen', () {
    createGoldenTest<LoginScreen>(
      testName: 'login_screen',
      renderScreen: const LoginScreen(),
      findScreen: LoginScreen,
      overrideRiverPod: [
        authNotifierProvider.overrideWith(MockAuthNotifier.new),
      ],
    );
  });
}
