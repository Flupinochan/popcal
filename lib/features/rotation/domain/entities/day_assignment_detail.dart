import 'package:popcal/features/rotation/domain/entities/current_assignment.dart';

/// 日付選択時のポップアップ表示用データ
class DayAssignmentDetail {
  /// 対象日付
  final DateTime date;

  /// ローテーショングループのタイトル
  final String rotationGroupTitle;

  /// その日の全役割割り当て
  final List<CurrentAssignment> assignments;

  /// スキップが発生した日かどうか
  final bool isSkipped;

  const DayAssignmentDetail({
    required this.date,
    required this.rotationGroupTitle,
    required this.assignments,
    required this.isSkipped,
  });

  /// ポップアップタイトル用の日付文字列
  String get dateText => '${date.month}月${date.day}日';

  /// 割り当て情報の箇条書き表示用
  List<String> get assignmentTexts {
    return assignments
        .map((assignment) => assignment.notificationText)
        .toList();
  }

  /// スキップ状態の表示テキスト
  String get skipStatusText => isSkipped ? '（スキップあり）' : '';
}
