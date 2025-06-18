/// 一時的なスキップ記録を管理するエンティティ
/// その週のみ有効な割り当て変更情報
class SkipRecord {
  /// スキップレコードの一意識別子
  final String id;

  /// 対象のローテーショングループID
  final String rotationGroupId;

  /// スキップ対象の役割ID
  final String roleId;

  /// スキップされたメンバーID
  final String memberId;

  /// スキップ対象週の開始日（月曜日）
  /// 週単位でスキップを管理するため
  final DateTime targetWeekStart;

  /// その週でのスキップ回数
  /// 複数回スキップによるローテーション調整用
  final int skipCount;

  /// スキップ実行日時
  final DateTime createdAt;

  const SkipRecord({
    required this.id,
    required this.rotationGroupId,
    required this.roleId,
    required this.memberId,
    required this.targetWeekStart,
    required this.skipCount,
    required this.createdAt,
  });

  /// スキップが有効かどうか（対象週内かどうか）
  bool isValidForDate(DateTime date) {
    final weekEnd = targetWeekStart.add(const Duration(days: 6));
    return date.isAfter(targetWeekStart.subtract(const Duration(days: 1))) &&
        date.isBefore(weekEnd.add(const Duration(days: 1)));
  }

  /// このスキップレコードが期限切れかどうか
  bool get isExpired {
    final oneWeekAfter = targetWeekStart.add(const Duration(days: 7));
    return DateTime.now().isAfter(oneWeekAfter);
  }
}
