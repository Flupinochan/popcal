/// カレンダー表示用の日付データを表現するエンティティ
class CalendarDay {
  /// 対象日付
  final DateTime date;

  /// その日の担当者名リスト
  /// カレンダーの各日付に表示する名前の箇条書き用
  final List<String> memberNames;

  /// 割り当てが存在するかどうか
  /// true: ローテーション実行日, false: 非実行日
  final bool hasAssignment;

  /// スキップが発生した日かどうか
  final bool isSkipped;

  const CalendarDay({
    required this.date,
    required this.memberNames,
    required this.hasAssignment,
    required this.isSkipped,
  });

  /// カレンダー表示用の日付文字列
  String get dayText => date.day.toString();

  /// メンバー名の箇条書き表示用文字列
  String get memberNamesText => memberNames.join('\n');

  /// 表示スタイルの判定用
  bool get isToday {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }
}
