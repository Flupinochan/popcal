enum ScheduleDayType {
  /// ローテーション対象外の日
  notRotationDay('対象外'),

  /// 休日スキップされた日
  holiday('休日'),

  /// 通常のローテーション日
  rotationDay('担当日');

  const ScheduleDayType(this.displayText);

  final String displayText;

  /// ローテーション日かどうか（holiday以外のrotationDay）
  bool get isActiveRotationDay => this == ScheduleDayType.rotationDay;

  /// 何らかのローテーション関連の日かどうか
  bool get isRotationRelated => this != ScheduleDayType.notRotationDay;
}
