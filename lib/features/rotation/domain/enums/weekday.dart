import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

enum Weekday {
  monday(1, '月'),
  tuesday(2, '火'),
  wednesday(3, '水'),
  thursday(4, '木'),
  friday(5, '金'),
  saturday(6, '土'),
  sunday(7, '日');

  const Weekday(this.value, this.displayName);

  /// DateTime.weekday と同じ値 (1=月曜, 2=火曜, ..., 7=日曜)
  final int value;
  final String displayName;

  /// DateTime => Weekday
  static Weekday fromDateTime(DateTime dateTime) {
    return fromInt(dateTime.weekday);
  }

  /// int => Weekday
  static Weekday fromInt(int value) {
    return Weekday.values.firstWhere(
      (weekday) => weekday.value == value,
      orElse:
          () =>
              throw ArgumentError(
                'Invalid weekday value: $value (expected 1-7)',
              ),
    );
  }

  /// 土曜日は青色、日曜日は赤色
  static Color getWeekDayColor(int value) {
    if (value == 6) {
      return Colors.blue.withValues(alpha: 0.9);
    } else if (value == 7) {
      return Colors.redAccent.withValues(alpha: 0.8);
    } else {
      return GlassTheme.defaultTheme.surfaceColor;
    }
  }
}
