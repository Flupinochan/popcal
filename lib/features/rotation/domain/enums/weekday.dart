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
}
