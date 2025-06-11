/// スキップ選択肢を表現するエンティティ
/// Home画面の...メニューから表示するポップアップ用
class SkipOption {
  /// 対象役割のID
  final String roleId;

  /// 対象役割の名前
  final String roleName;

  /// スキップ対象メンバーのID
  final String memberId;

  /// スキップ対象メンバーの名前
  final String memberName;

  /// スキップ対象日時
  final DateTime targetDate;

  /// スキップ可能かどうか
  /// false: 既にスキップ済み、メンバーが1人のみなど
  final bool canSkip;

  /// スキップできない理由（canSkip=falseの場合）
  final String? skipDisabledReason;

  const SkipOption({
    required this.roleId,
    required this.roleName,
    required this.memberId,
    required this.memberName,
    required this.targetDate,
    required this.canSkip,
    this.skipDisabledReason,
  });

  /// ポップアップ表示用のタイトル
  String get displayTitle => '$roleName: $memberName';

  /// スキップ不可の場合の説明テキスト
  String get disabledReasonText => skipDisabledReason ?? 'スキップできません';
}
