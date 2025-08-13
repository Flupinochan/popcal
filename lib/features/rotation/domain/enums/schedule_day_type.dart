enum DayType {
  /// ローテーション対象外の日
  notRotationDay('対象外'),

  /// 通常のローテーション日
  rotationDay('担当日'),

  /// 次の人にskipする日
  skipToNext('次の人にスキップした日'),

  /// 前の人にskipする日
  skipToPrevious('前の人にスキップした日'),

  /// 休日（ローテーション除外）
  holiday('休日');

  const DayType(this.displayText);

  final String displayText;
}
