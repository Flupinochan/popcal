import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class CustomLoadingSimpleScreen extends StatelessWidget {
  const CustomLoadingSimpleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Center(
      child: CircularProgressIndicator(color: glassTheme.surfaceColor),
    );
  }
}
