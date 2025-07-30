import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({super.key, this.message = 'エラーが発生しました'});

  @override
  Widget build(BuildContext context) {
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: GlassDialog(
              icon: Icons.priority_high,
              message: message,
              iconColor: glassTheme.errorBorderColor,
              backgroundGradient: glassTheme.errorGradient,
              borderColor: glassTheme.errorBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}
