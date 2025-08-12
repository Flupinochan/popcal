import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:popcal/core/themes/app_theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return await AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      forceUpdateGoldenFiles: false,
      theme: AppTheme.lightTheme,
      platformGoldensConfig: PlatformGoldensConfig(
        platforms: HostPlatform.values,
        theme: AppTheme.lightTheme,
      ),
      ciGoldensConfig: CiGoldensConfig(
        theme: AppTheme.lightTheme,
      ),
    ),
    run: testMain,
  );
}
