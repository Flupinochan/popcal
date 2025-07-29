import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

/// ガラス風Icon Widget
class GlassIcon extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final double? backgroundSize;
  final Color? iconColor;
  final EdgeInsets? margin;
  final bool showBorder;
  final Gradient? backgroundGradient;
  final Color? borderColor;

  const GlassIcon({
    super.key,
    required this.iconData,
    this.iconSize = 24,
    this.iconColor,
    this.backgroundSize,
    this.margin,
    this.showBorder = false,
    this.backgroundGradient,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    // デフォルトの背景のサイズはIconの2倍
    final size = backgroundSize ?? (iconSize * 2);
    // 背景色を少し濃い目の白
    final defaultGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: 0.25),
        Colors.white.withValues(alpha: 0.125),
      ],
    );

    return Container(
      width: size,
      height: size,
      margin: margin,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: backgroundGradient ?? defaultGradient,
              shape: BoxShape.circle,
              border:
                  showBorder
                      ? Border.all(
                        color: borderColor ?? glass.borderColor,
                        width: glass.borderWidth,
                      )
                      : null,
            ),
            child: Icon(
              iconData,
              size: iconSize,
              color: iconColor ?? glass.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
