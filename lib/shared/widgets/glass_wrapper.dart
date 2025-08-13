import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

/// Text WidgetなどシンプルなWidgetで使用する共通のガラス風スタイル
class GlassWrapper extends StatelessWidget {
  const GlassWrapper({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.showBorder = true,
    this.borderColor,
    this.gradient,
    this.showBackground = true,
    this.borderRadius,
  });

  // ガラス風スタイルを適用する子Widgetを指定
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AlignmentGeometry alignment;
  final bool showBorder;
  final Color? borderColor;
  final Gradient? gradient;
  final bool showBackground;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Container(
      width: width,
      height: height,
      margin: margin,
      // ClipRRect: 角丸
      child: ClipRRect(
        borderRadius:
            borderRadius == null
                ? BorderRadius.circular(glassTheme.borderRadius)
                : BorderRadius.circular(borderRadius!),
        // BackdropFilter, ImageFilter: 背景をぼかす
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: glassTheme.blur,
            sigmaY: glassTheme.blur,
          ),
          child: Container(
            alignment: alignment,
            padding: padding,
            // BoxDecoration: 薄白透明背景, 境界線
            decoration: BoxDecoration(
              gradient:
                  showBackground
                      ? (gradient ?? glassTheme.backgroundGradient)
                      : glassTheme.transparentGradient,
              borderRadius:
                  borderRadius == null
                      ? BorderRadius.circular(glassTheme.borderRadius)
                      : BorderRadius.circular(borderRadius!),
              border:
                  showBorder
                      ? Border.all(
                        color: borderColor ?? glassTheme.borderColor,
                        width: glassTheme.borderWidth,
                      )
                      : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
