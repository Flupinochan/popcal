import 'package:flutter/material.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content_with_action.dart';

class SnackBarUtils {
  // 基本的なGlassSnackBarを表示
  static void showGlassSnackBar(
    ScaffoldMessengerState scaffoldMessenger,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassSnackbarContent(message: message),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
      ),
    );
  }

  // アクション付きGlassSnackBarを表示
  static void showGlassSnackBarWithAction(
    ScaffoldMessengerState scaffoldMessenger,
    String message, {
    required VoidCallback onAction,
    String actionLabel = '元に戻す',
    Duration duration = const Duration(seconds: 5),
  }) {
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassSnackbarContentWithAction(
          message: message,
          onAction: onAction,
          actionLabel: actionLabel,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
      ),
    );
  }
}
