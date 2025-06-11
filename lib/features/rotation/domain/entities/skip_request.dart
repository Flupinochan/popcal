/// スキップ実行要求を表現するエンティティ
/// ユーザーからのスキップ操作をカプセル化
class SkipRequest {
  /// 対象のローテーショングループID
  final String rotationGroupId;

  /// スキップする役割ID
  final String roleId;

  /// スキップするメンバーID
  final String memberId;

  /// スキップ対象日時
  final DateTime targetDate;

  const SkipRequest({
    required this.rotationGroupId,
    required this.roleId,
    required this.memberId,
    required this.targetDate,
  });

  /// 対象週の開始日（月曜日）を計算
  DateTime get targetWeekStart {
    final weekday = targetDate.weekday;
    final daysToSubtract = weekday - 1; // 月曜日=1なので
    return DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    ).subtract(Duration(days: daysToSubtract));
  }
}
