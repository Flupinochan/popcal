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
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Gradient? gradient;
  final bool showBorder;
  final bool showBackground;
  final double iconTextSpacing;
  final Alignment alignment;
  final EdgeInsets? padding;

  const GlassButton({
    super.key,
    this.text,
    this.textStyle,
    this.iconData,
    this.iconSize = 24,
    this.iconColor,
    this.backgroundSize,
    this.onPressed,
    this.width,
    this.height,
    this.borderColor,
    this.gradient,
    this.showBorder = true,
    this.showBackground = true,
    this.iconTextSpacing = 8,
    this.alignment = Alignment.center,
    this.padding,
  }) : assert(text != null || iconData != null, 'textまたはiconのどちらかを指定してください');

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final effectiveIconColor = iconColor ?? glass.iconColor;
    final effectiveTextStyle =
        textStyle ?? Theme.of(context).textTheme.bodyLarge;

    Widget child;

    if (text != null && iconData != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData!, size: iconSize, color: effectiveIconColor),
          SizedBox(width: iconTextSpacing),
          Text(text!, style: effectiveTextStyle),
        ],
      );
    } else if (text != null) {
      // テキストのみ
      child = Text(text!, style: effectiveTextStyle);
    } else {
      // アイコンのみ
      child = Icon(iconData!, size: iconSize, color: effectiveIconColor);
    }

    if (padding != null) {
      child = Padding(padding: padding!, child: child);
    }

    // サイズの計算
    final isIconOnly = text == null && iconData != null;
    final defaultSize = backgroundSize ?? (iconSize! * 2);

    return GlassWrapper(
      width: isIconOnly ? defaultSize : width,
      height: isIconOnly ? defaultSize : height,
      borderColor: borderColor,
      showBorder: showBorder,
      gradient: gradient,
      showBackground: showBackground,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Align(alignment: alignment, child: child),
        ),
      ),
    );
  }
}
