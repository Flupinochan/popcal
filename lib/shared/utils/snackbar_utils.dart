import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class SnackBarUtils {
  // 表示のみSnackBar ※contextは渡せないため注意
  static void showGlassSnackBar({
    required TextTheme textTheme,
    required GlassTheme glassTheme,
    required ScaffoldMessengerState scaffoldMessenger,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassWrapper(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(message, style: textTheme.bodyLarge),
        ),
        backgroundColor: glassTheme.backgroundColor,
        elevation: 0,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  // アクション付きSnackBar
  static void showGlassSnackBarWithAction({
    required TextTheme textTheme,
    required GlassTheme glassTheme,
    required ScaffoldMessengerState scaffoldMessenger,
    required String message,
    required VoidCallback onAction,
    required String actionLabel,
    Duration duration = const Duration(seconds: 5),
  }) {
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassWrapper(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message, style: textTheme.bodyLarge),
              const SizedBox(width: 24),
              GlassButton(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                gradient: glassTheme.backgroundGradientStrong,
                text: actionLabel,
                textStyle: textTheme.labelLarge,
                onPressed: () {
                  onAction();
                  scaffoldMessenger.hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
        backgroundColor: glassTheme.backgroundColor,
        elevation: 0,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }
}
