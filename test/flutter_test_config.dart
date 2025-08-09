import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:popcal/core/themes/app_theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      forceUpdateGoldenFiles: false,
      theme: AppTheme.lightTheme,
      platformGoldensConfig: PlatformGoldensConfig(
        platforms: HostPlatform.values,
        enabled: true,
        obscureText: false,
        renderShadows: true,
        theme: AppTheme.lightTheme,
      ),
      ciGoldensConfig: CiGoldensConfig(
        enabled: true,
        obscureText: true,
        renderShadows: false,
        theme: AppTheme.lightTheme,
      ),
    ),
    run: testMain,
  );
}
