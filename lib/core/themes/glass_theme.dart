import 'dart:ui';

import 'package:flutter/material.dart';

/// ThemeDataを拡張
/// 独自Widgetのスタイルのプロパティを定義
@immutable
class GlassTheme extends ThemeExtension<GlassTheme> {
  const GlassTheme({
    required this.blur, // ぼかし強度
    required this.borderColor, // 境界線の色
    required this.borderWidth, // 境界線の太さ
    required this.borderRadius, // 角の丸み
    required this.backgroundGradient, // 背景グラデーション
  });

  final double blur;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final LinearGradient backgroundGradient;

  /// デフォルトのテーマのプロパティをオーバーライドしてスタイルを適用するためのメソッド
  @override
  GlassTheme copyWith({
    double? blur,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    LinearGradient? backgroundGradient,
    LinearGradient? accentGradient,
    LinearGradient? errorGradient,
  }) {
    return GlassTheme(
      blur: blur ?? this.blur,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  /// テーマ切り替え用 ※定義必須
  @override
  GlassTheme lerp(GlassTheme? other, double t) {
    if (other is! GlassTheme) return this;

    return GlassTheme(
      blur: lerpDouble(blur, other.blur, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      backgroundGradient:
          LinearGradient.lerp(backgroundGradient, other.backgroundGradient, t)!,
    );
  }

  /// デフォルトのテーマを定義
  static const defaultTheme = GlassTheme(
    blur: 20.0,
    borderColor: Color(0x33FFFFFF),
    borderWidth: 1.0,
    borderRadius: 12.0,
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0x1AFFFFFF), Color(0x0DFFFFFF)],
    ),
  );
}
