class Deadline {
  const Deadline({
    required this.isEnabled,
  });

  final bool isEnabled;

  Deadline copyWith({
    bool? isEnabled,
  }) {
    return Deadline(
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  // 通知のon/offを切り替え
  Deadline toggle() {
    return copyWith(isEnabled: !isEnabled);
  }
}
