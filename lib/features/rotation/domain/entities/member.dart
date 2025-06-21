/// メンバーを表現するエンティティ
class Member {
  final String id;

  /// メンバー名（ユーザーが入力）
  /// 例: "田中一郎", "佐藤次郎"
  final String name;

  /// 役割固定モードの場合の所属役割ID
  /// roleFixedの場合のみ設定、roleRotationの場合はnull
  final String? roleId;

  /// 表示順序（UI表示時の並び順制御）
  final int sortOrder;

  const Member({
    required this.id,
    required this.name,
    this.roleId,
    required this.sortOrder,
  });

  /// メンバー名の表示用文字列
  String get displayName => name;

  /// 特定の役割に所属しているかチェック
  bool belongsToRole(String targetRoleId) => roleId == targetRoleId;

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'roleId': roleId, 'sortOrder': sortOrder};
  }
}
