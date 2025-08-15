class MonthEndSettings {
  const MonthEndSettings({
    required this.isEnabled,
  });

  // 初期値はfalseで作成
  factory MonthEndSettings.defaultSettings() {
    return const MonthEndSettings(
      isEnabled: false,
    );
  }

  final bool isEnabled;

  MonthEndSettings copyWith({
    bool? isEnabled,
  }) {
    return MonthEndSettings(
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  // 通知のon/offを切り替え
  MonthEndSettings toggle() {
    return copyWith(isEnabled: !isEnabled);
  }
}
