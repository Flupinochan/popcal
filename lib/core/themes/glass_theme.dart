import 'dart:ui';

import 'package:flutter/material.dart';

/// ThemeDataを拡張
/// 独自Widgetのスタイルのプロパティを定義
@immutable
class GlassTheme extends ThemeExtension<GlassTheme> {
  const GlassTheme({
    required this.blur, // ぼかし強度
    required this.borderColor, // 境界線の色
    required this.borderColorStrong,
    required this.borderWidth, // 境界線の太さ
    required this.borderRadius, // 角の丸み
    required this.iconColor, // IconColor
    required this.backgroundGradient, // 背景グラデーション
    required this.backgroundGradientStrong,
  });

  final double blur;
  final Color borderColor;
  final Color borderColorStrong;
  final double borderWidth;
  final double borderRadius;
  final Color iconColor;
  final LinearGradient backgroundGradient;
  final LinearGradient backgroundGradientStrong;

  /// デフォルトのテーマのプロパティをオーバーライドしてスタイルを適用するためのメソッド
  @override
  GlassTheme copyWith({
    double? blur,
    Color? borderColor,
    Color? borderColorStrong,
    double? borderWidth,
    double? borderRadius,
    Color? iconColor,
    LinearGradient? backgroundGradient,
    LinearGradient? backgroundGradientStrong,
  }) {
    return GlassTheme(
      blur: blur ?? this.blur,
      borderColor: borderColor ?? this.borderColor,
      borderColorStrong: borderColorStrong ?? this.borderColorStrong,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      iconColor: iconColor ?? this.iconColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      backgroundGradientStrong:
          backgroundGradientStrong ?? this.backgroundGradientStrong,
    );
  }

  /// テーマ切り替え用 ※定義必須
  @override
  GlassTheme lerp(GlassTheme? other, double t) {
    if (other is! GlassTheme) return this;

    return GlassTheme(
      blur: lerpDouble(blur, other.blur, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderColorStrong:
          Color.lerp(borderColorStrong, other.borderColorStrong, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      backgroundGradient:
          LinearGradient.lerp(backgroundGradient, other.backgroundGradient, t)!,
      backgroundGradientStrong:
          LinearGradient.lerp(
            backgroundGradientStrong,
            other.backgroundGradientStrong,
            t,
          )!,
    );
  }

  /// デフォルトのテーマを定義 ※finalは再起動が必要
  static final defaultTheme = GlassTheme(
    blur: 20.0,
    borderColor: Colors.white.withValues(alpha: 0.2),
    borderColorStrong: Colors.white.withValues(alpha: 0.4),
    borderWidth: 1.0,
    borderRadius: 12.0,
    iconColor: Colors.white.withValues(alpha: 0.8),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: 0.1),
        Colors.white.withValues(alpha: 0.05),
      ],
    ),
    backgroundGradientStrong: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: 0.3),
        Colors.white.withValues(alpha: 0.15),
      ],
    ),
  );
}
