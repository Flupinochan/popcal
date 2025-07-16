/// 曜日を表すEnum
/// Dartの DateTime.weekday と同じ値体系を使用
/// (月曜日=1, 火曜日=2, ..., 日曜日=7)
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

  /// UI表示用の日本語名
  final String displayName;

  /// DateTime => Weekday に変換
  static Weekday fromDateTime(DateTime dateTime) {
    return fromInt(dateTime.weekday);
  }

  /// int => Weekday に変換
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
}
