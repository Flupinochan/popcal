import 'package:popcal/features/rotation/domain/entities/member.dart';
import 'package:popcal/features/rotation/domain/entities/role.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_schedule.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_type.dart';

/// 中核となるデータ構造
class RotationGroup {
  final String id;

  /// グループ名（Home画面のリスト表示で使用）
  final String title;

  /// ローテーションの種類
  /// 1. roleRotation: 役割もローテーション
  /// 2. roleFixed: 役割固定
  final RotationType rotationType;

  /// 管理する役割一覧
  /// 例: 議事、ファシリテータ、タイムキーパー
  final List<Role> roles;

  /// 所属するメンバー一覧
  final List<Member> members;

  /// ローテーションのスケジュール設定
  final RotationSchedule schedule;

  /// 作成日時
  final DateTime createdAt;

  /// 最終更新日時
  final DateTime updatedAt;

  const RotationGroup({
    required this.id,
    required this.title,
    required this.rotationType,
    required this.roles,
    required this.members,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
  });

  /// グループのアクティブ状態を判定
  /// 開始日が未来の場合は非アクティブ
  bool get isActive => DateTime.now().isAfter(schedule.startDateTime);

  /// 次回のローテーション実行日を計算
  DateTime? get nextRotationDate {
    // この計算はユースケースで実装
    return null;
  }
}
