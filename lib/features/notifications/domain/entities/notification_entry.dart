import 'package:popcal/features/auth/domain/value_objects/user_id.dart';

/// 通知設定
class NotificationEntry {
  final int notificationId;
  // rotationIdはポップアップをタップした際に、カレンダー画面を表示するさいに必要
  final String rotationId;
  final UserId userId;
  // 以下ポップアップの通知情報
  final String rotationName;
  final DateTime notificationTime;
  final String memberName;
  final DateTime rotationStartDate;

  const NotificationEntry({
    required this.notificationId,
    required this.rotationId,
    required this.userId,
    required this.rotationName,
    required this.notificationTime,
    required this.memberName,
    required this.rotationStartDate,
  });

  String generateTitle() => rotationName;
  String generateDescription() => '$rotationNameの通知';
  String generateContent() => '今日は$memberNameの番です';

  String get title => generateTitle();
  String get description => generateDescription();
  String get content => generateContent();

  @override
  String toString() {
    return 'RotationNotification(id: $notificationId, time: $notificationTime, member: $memberName)';
  }
}
