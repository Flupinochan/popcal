/// 曜日を表現するEnum
enum DayOfWeek {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const DayOfWeek(this.value);

  /// 数値表現（月曜日=1, 日曜日=7）
  final int value;

  /// 日本語表示名
  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return '月曜日';
      case DayOfWeek.tuesday:
        return '火曜日';
      case DayOfWeek.wednesday:
        return '水曜日';
      case DayOfWeek.thursday:
        return '木曜日';
      case DayOfWeek.friday:
        return '金曜日';
      case DayOfWeek.saturday:
        return '土曜日';
      case DayOfWeek.sunday:
        return '日曜日';
    }
  }

  /// 短縮表示名
  String get shortName {
    switch (this) {
      case DayOfWeek.monday:
        return '月';
      case DayOfWeek.tuesday:
        return '火';
      case DayOfWeek.wednesday:
        return '水';
      case DayOfWeek.thursday:
        return '木';
      case DayOfWeek.friday:
        return '金';
      case DayOfWeek.saturday:
        return '土';
      case DayOfWeek.sunday:
        return '日';
    }
  }
}
