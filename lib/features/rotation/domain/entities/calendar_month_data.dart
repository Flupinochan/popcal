import 'package:popcal/features/rotation/domain/entities/calendar_day.dart';

/// 月カレンダー表示用のデータ構造
class CalendarMonthData {
  /// 表示年
  final int year;

  /// 表示月（1-12）
  final int month;

  /// その月の全日付データ
  final List<CalendarDay> days;

  /// 対象のローテーショングループタイトル
  final String rotationGroupTitle;

  const CalendarMonthData({
    required this.year,
    required this.month,
    required this.days,
    required this.rotationGroupTitle,
  });

  /// カレンダーヘッダー用の年月文字列
  String get yearMonthText => '$year年${month}月';

  /// 前月の年月
  DateTime get previousMonth {
    if (month == 1) {
      return DateTime(year - 1, 12);
    }
    return DateTime(year, month - 1);
  }

  /// 次月の年月
  DateTime get nextMonth {
    if (month == 12) {
      return DateTime(year + 1, 1);
    }
    return DateTime(year, month + 1);
  }

  /// 割り当てがある日のみを取得
  List<CalendarDay> get assignmentDays {
    return days.where((day) => day.hasAssignment).toList();
  }
}
