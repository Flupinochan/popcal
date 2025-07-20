import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

// ガラス風Button Widget
class GlassButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const GlassButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GlassWrapper(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            GlassTheme.defaultTheme.borderRadius,
          ),
          child: Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
