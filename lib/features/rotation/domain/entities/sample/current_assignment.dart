/// 現在の役割割り当て状況を表現するエンティティ
/// リアルタイムの割り当て状況を管理（スキップ考慮済み）
class CurrentAssignment {
  /// 割り当てられた役割のID
  final String roleId;

  /// 割り当てられた役割の名前
  final String roleName;

  /// 担当者のID
  final String memberId;

  /// 担当者の名前
  final String memberName;

  /// この割り当ての対象日時
  final DateTime assignedDate;

  const CurrentAssignment({
    required this.roleId,
    required this.roleName,
    required this.memberId,
    required this.memberName,
    required this.assignedDate,
  });

  /// 通知表示用の文字列
  String get notificationText => '$roleName: $memberName';

  /// カレンダー表示用の簡潔な文字列
  String get calendarDisplayText => memberName;
}
