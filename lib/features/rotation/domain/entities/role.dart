/// 役割を表現するエンティティ
/// 例: 議事、ファシリテータ、タイムキーパー
class Role {
  final String id;

  /// 役割名（ユーザーが入力）
  /// 例: "議事", "ファシリテータ", "タイムキーパー"
  final String name;

  /// 表示順序（UI表示時の並び順制御）
  final int sortOrder;

  const Role({required this.id, required this.name, required this.sortOrder});

  /// 役割名の表示用文字列
  String get displayName => name;
}
