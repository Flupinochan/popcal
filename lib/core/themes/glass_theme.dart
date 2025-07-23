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
    required this.transparentGradient,
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryGradient,
    required this.surfaceColor,
    required this.backgroundColor,
    required this.errorBorderColor,
    required this.errorGradient,
    required this.successGradient,
  });

  final double blur;
  final Color borderColor;
  final Color borderColorStrong;
  final double borderWidth;
  final double borderRadius;
  final Color iconColor;
  final LinearGradient backgroundGradient;
  final LinearGradient backgroundGradientStrong;
  final LinearGradient transparentGradient;
  final Color primaryColor;
  final Color secondaryColor;

  /// 青紫背景色
  final LinearGradient primaryGradient;

  /// 白
  final Color surfaceColor;

  /// 透明
  final Color backgroundColor;

  final Color errorBorderColor;
  final LinearGradient errorGradient;
  final LinearGradient successGradient;

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
    LinearGradient? transparentGradient,
    Color? primaryColor,
    Color? secondaryColor,
    LinearGradient? primaryGradient,
    Color? surfaceColor,
    Color? backgroundColor,
    Color? errorBorderColor,
    LinearGradient? errorGradient,
    LinearGradient? successGradient,
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
      transparentGradient: transparentGradient ?? this.transparentGradient,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorBorderColor: errorBorderColor ?? this.borderColor,
      errorGradient: errorGradient ?? this.errorGradient,
      successGradient: successGradient ?? this.successGradient,
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
      transparentGradient:
          LinearGradient.lerp(
            transparentGradient,
            other.transparentGradient,
            t,
          )!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      primaryGradient:
          LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      errorBorderColor:
          Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      errorGradient:
          LinearGradient.lerp(errorGradient, other.errorGradient, t)!,
      successGradient:
          LinearGradient.lerp(successGradient, other.successGradient, t)!,
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
    transparentGradient: LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
    ),
    primaryColor: Color(0xFF667eea),
    secondaryColor: Color(0xFF764ba2),
    primaryGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    ),
    surfaceColor: Colors.white,
    backgroundColor: Colors.transparent,
    errorBorderColor: Colors.redAccent.withValues(alpha: 0.4),
    errorGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.redAccent.withValues(alpha: 0.4),
        Colors.redAccent.withValues(alpha: 0.2),
      ],
    ),
    successGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.greenAccent.withValues(alpha: 0.3),
        Colors.greenAccent.withValues(alpha: 0.3),
      ],
    ),
  );
}
