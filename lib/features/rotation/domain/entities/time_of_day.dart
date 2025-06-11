/// 時刻を表現するValue Object
class TimeOfDay {
  /// 時（0-23）
  final int hour;

  /// 分（0-59）
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  /// HH:mm形式の文字列表現
  String get displayTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// 妥当性チェック
  bool get isValid {
    return hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59;
  }

  /// DateTime型に変換（特定の日付と組み合わせ）
  DateTime toDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
