import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    const primaryColor = Colors.white;
    final primaryHigh = primaryColor.withValues(alpha: 0.9);
    final primaryMedium = primaryColor.withValues(alpha: 0.8);
    // final primaryLow = primaryColor.withValues(alpha: 0.6);
    // final primaryDisabled = primaryColor.withValues(alpha: 0.4);

    final customTextTheme = baseTheme.textTheme.copyWith(
      // 大見出し - スクリーンタイトル、Welcomeメッセージ
      headlineLarge: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      // 中見出し - セクションタイトル、カードタイトル
      titleLarge: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      // 小見出し - リストアイテム、サブタイトル
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryHigh,
      ),
      // 本文 - 通常のテキスト
      bodyLarge: const TextStyle(fontSize: 16, color: primaryColor),
      // 説明文 - 詳細説明、ボタンテキスト
      bodyMedium: TextStyle(
        fontSize: 14,
        color: primaryMedium,
      ),
      // 副次情報 - ヒント、メタ情報
      bodySmall: TextStyle(
        fontSize: 12,
        color: primaryMedium,
      ),
      labelLarge: const TextStyle(
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: const TextStyle(
        color: primaryColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: primaryHigh,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );

    return baseTheme.copyWith(
      textTheme: customTextTheme.apply(fontFamily: 'NotoSansJP'),
      extensions: [GlassTheme.defaultTheme],
    );
  }
}
