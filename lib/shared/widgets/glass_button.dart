import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

/// ガラス風Button Widget
class GlassButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final IconData? iconData;
  final double? iconSize;
  final Color? iconColor;
  final double? backgroundSize;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Gradient? gradient;

  const GlassButton({
    super.key,
    this.text,
    this.textStyle,
    this.iconData,
    this.iconSize = 24,
    this.iconColor,
    this.backgroundSize,
    required this.onPressed,
    this.width,
    this.height,
    this.borderColor,
    this.gradient,
  }) : assert(text != null || iconData != null, 'textまたはiconのどちらかを指定してください');

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    Widget child;

    // テキスト・アイコンで分岐
    final size = backgroundSize ?? (iconSize! * 2);
    if (text != null) {
      child = Text(
        text!,
        style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      );
    } else {
      child = Icon(iconData!, size: iconSize, color: glass.iconColor);
    }

    return GlassWrapper(
      width: text != null ? width : size,
      height: text != null ? height : size,
      borderColor: borderColor,
      gradient: gradient,
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onPressed, child: Center(child: child)),
      ),
    );
  }
}
