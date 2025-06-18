/// 履歴保持期間の設定を管理するエンティティ
class HistoryRetentionConfig {
  /// 履歴保持期間（日数）
  /// デフォルト: 365日（1年間）
  final int retentionDays;

  /// 自動削除を有効にするかどうか
  final bool autoDeleteEnabled;

  /// 自動削除の実行頻度（日数）
  /// デフォルト: 30日ごとに実行
  final int autoDeleteIntervalDays;

  const HistoryRetentionConfig({
    this.retentionDays = 365,
    this.autoDeleteEnabled = true,
    this.autoDeleteIntervalDays = 30,
  });

  /// 指定日付が保持期間内かどうか
  bool isWithinRetentionPeriod(DateTime date) {
    final cutoffDate = DateTime.now().subtract(Duration(days: retentionDays));
    return date.isAfter(cutoffDate);
  }

  /// 削除対象日付の境界を取得
  DateTime get deletionCutoffDate {
    return DateTime.now().subtract(Duration(days: retentionDays));
  }
}
