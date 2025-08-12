import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({
    required this.height,
    required this.circleHeight,
    super.key,
  });

  final double height;
  final double circleHeight;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      width: double.infinity,
      height: height,
      child: SizedBox(
        height: circleHeight,
        width: circleHeight,
        child: Center(
          child: CircularProgressIndicator(
            color: glassTheme.surfaceColor,
          ),
        ),
      ),
    );
  }
}
