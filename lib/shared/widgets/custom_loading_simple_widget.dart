import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

Widget customLoadingSimpleWidget(BuildContext context) {
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

  return Center(
    child: CircularProgressIndicator(color: glassTheme.surfaceColor),
  );
}
