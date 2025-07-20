import 'package:flutter/material.dart';
import 'glass_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Textスタイル定義
      textTheme: TextTheme(
        // 大見出し - スクリーンタイトル、Welcomeメッセージ
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        // 中見出し - セクションタイトル、カードタイトル
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        // 小見出し - リストアイテム、サブタイトル
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        // 本文 - 通常のテキスト
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        // 説明文 - 詳細説明、ボタンテキスト
        bodyMedium: TextStyle(
          fontSize: 14,
          // withOpacity ではなく withValues で alpha を指定して透過させる
          color: Colors.white.withValues(alpha: 0.8),
        ),
        // 副次情報 - ヒント、メタ情報
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.8),
        ),
      ),
      // Glass用スタイル定義
      extensions: [GlassTheme.defaultTheme],
    );
  }
}
