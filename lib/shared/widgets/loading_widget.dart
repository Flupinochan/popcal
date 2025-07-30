import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;

    return Center(
      child: CircularProgressIndicator(color: glassTheme.surfaceColor),
    );
  }
}
