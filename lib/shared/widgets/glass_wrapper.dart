import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

/// Text WidgetなどシンプルなWidgetで使用する共通のガラス風スタイル適用用Wrapper Widget
class GlassWrapper extends StatelessWidget {
  // ガラス風スタイルを適用するWidgetを指定
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AlignmentGeometry alignment;
  final bool showBorder;

  const GlassWrapper({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

    return Container(
      width: width,
      height: height,
      margin: margin,
      // ClipRRect: 角丸
      child: ClipRRect(
        borderRadius: BorderRadius.circular(glass.borderRadius),
        // BackdropFilter, ImageFilter: 背景をぼかす
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
          child: Container(
            alignment: alignment,
            padding: padding,
            // BoxDecoration: 薄白透明背景, 境界線
            decoration: BoxDecoration(
              gradient: glass.backgroundGradient,
              borderRadius: BorderRadius.circular(glass.borderRadius),
              border:
                  showBorder
                      ? Border.all(
                        color: glass.borderColor,
                        width: glass.borderWidth,
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
