import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

/// ガラス風Icon Widget
class GlassIcon extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final double? backgroundSize;
  final Color iconColor;
  final EdgeInsets? margin;
  final bool showBorder;

  const GlassIcon({
    super.key,
    required this.iconData,
    this.iconSize = 24,
    this.iconColor = Colors.white,
    this.backgroundSize,
    this.margin,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    // デフォルトの背景のサイズはIconの2倍
    final size = backgroundSize ?? (iconSize * 2);
    // 背景色を少し濃い目の白
    final iconTheme = glass.copyWith(
      backgroundGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x40FFFFFF), Color(0x20FFFFFF)],
      ),
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
              gradient: iconTheme.backgroundGradient,
              shape: BoxShape.circle,
              border:
                  showBorder
                      ? Border.all(
                        color: glass.borderColor,
                        width: glass.borderWidth,
                      )
                      : null,
            ),
            child: Icon(iconData, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }
}
