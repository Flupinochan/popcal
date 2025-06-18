import 'package:popcal/features/rotation/domain/entities/sample/current_assignment.dart';

/// ローテーション履歴を保存するエンティティ
/// カレンダー表示用
class AssignmentHistory {
  final String id;

  /// 対象のローテーショングループID
  final String rotationGroupId;

  /// 割り当て実行日時
  final DateTime assignedDate;

  /// その日の全役割割り当て情報
  final List<CurrentAssignment> assignments;

  /// スキップが発生したかどうか
  /// true: 通常とは異なる割り当て, false: 通常の割り当て
  final bool isSkipped;

  /// 履歴作成日時
  final DateTime createdAt;

  const AssignmentHistory({
    required this.id,
    required this.rotationGroupId,
    required this.assignedDate,
    required this.assignments,
    required this.isSkipped,
    required this.createdAt,
  });

  /// この履歴が期限切れかどうか（1年以上前）
  bool get isExpired {
    final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
    return assignedDate.isBefore(oneYearAgo);
  }

  /// カレンダー表示用のメンバー名リスト
  List<String> get memberNames {
    return assignments.map((assignment) => assignment.memberName).toList();
  }
}
