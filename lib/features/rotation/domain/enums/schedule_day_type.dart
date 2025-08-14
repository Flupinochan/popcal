import 'package:flutter/material.dart';

enum DayType {
  /// ローテーション対象外の日
  notRotationDay('対象外'),

  /// 通常のローテーション日
  rotationDay('ローテーション日'),

  /// 次の人にskipする日
  skipToNext('次の人にスキップした日'),

  /// 休日（ローテーション除外）
  holiday('休日');

  const DayType(this.displayText);

  final String displayText;

  /// カレンダー画面の各日付の背景色
  /// UI側でさらに、選択日をblue、今日をamber色で定義
  Color get bkColor {
    switch (this) {
      case DayType.notRotationDay:
        return Colors.transparent;
      case DayType.rotationDay:
        return Colors.greenAccent.withValues(alpha: 0.3);
      case DayType.skipToNext:
        return Colors.lightGreenAccent.withValues(alpha: 0.4);
      case DayType.holiday:
        return Colors.redAccent.withValues(alpha: 0.3);
    }
  }

  Color get iconColor {
    switch (this) {
      case DayType.notRotationDay:
      case DayType.holiday:
        return Colors.white.withValues(alpha: 0.6);
      case DayType.rotationDay:
      case DayType.skipToNext:
        return Colors.white;
    }
  }

  LinearGradient get isRotationColor {
    switch (this) {
      case DayType.notRotationDay:
      case DayType.holiday:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.15),
          ],
        );
      case DayType.rotationDay:
      case DayType.skipToNext:
        final greenColor = Colors.greenAccent.withValues(alpha: 0.3);
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [greenColor, greenColor],
        );
    }
  }

  bool get isRotationDay {
    switch (this) {
      case DayType.notRotationDay:
      case DayType.holiday:
        return false;
      case DayType.rotationDay:
      case DayType.skipToNext:
        return true;
    }
  }
}
