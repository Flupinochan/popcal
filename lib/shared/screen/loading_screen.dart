import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

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
            child: CircularProgressIndicator(color: glassTheme.surfaceColor),
          ),
        ),
      ),
    );
  }
}
