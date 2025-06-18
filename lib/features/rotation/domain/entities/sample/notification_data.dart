import 'package:popcal/features/rotation/domain/entities/sample/assignment_info.dart';

/// プッシュ通知用のデータ構造
class NotificationData {
  /// 対象のローテーショングループID
  final String rotationGroupId;

  /// ローテーショングループのタイトル
  final String title;

  /// ミーティング開始時刻
  final DateTime meetingTime;

  /// その日の全割り当て情報
  final List<AssignmentInfo> assignments;

  const NotificationData({
    required this.rotationGroupId,
    required this.title,
    required this.meetingTime,
    required this.assignments,
  });

  /// プッシュ通知のタイトル
  String get notificationTitle => '$title のミーティング';

  /// プッシュ通知の本文
  String get notificationBody {
    final timeText =
        '${meetingTime.hour}:${meetingTime.minute.toString().padLeft(2, '0')} 開始';
    final assignmentTexts = assignments
        .map((assignment) => '${assignment.roleName}: ${assignment.memberName}')
        .join('\n');
    return '$timeText\n$assignmentTexts';
  }

  /// 通知データのMap表現（プッシュ通知ライブラリ用）
  Map<String, dynamic> toNotificationData() {
    return {
      'rotationGroupId': rotationGroupId,
      'title': title,
      'meetingTime': meetingTime.toIso8601String(),
      'assignments': assignments.map((a) => a.toMap()).toList(),
    };
  }
}
