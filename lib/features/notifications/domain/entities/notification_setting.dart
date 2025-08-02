/// 通知設定用
class NotificationSetting {
  final int notificationId;
  final String rotationGroupId;
  final String ownerUserId;
  final String rotationName;
  final DateTime notificationTime;
  final String memberName;
  final DateTime rotationStartDate;

  const NotificationSetting({
    required this.notificationId,
    required this.rotationGroupId,
    required this.ownerUserId,
    required this.rotationName,
    required this.notificationTime,
    required this.memberName,
    required this.rotationStartDate,
  });

  /// 通知タイトル
  String get title => rotationName;

  /// 通知本文
  String get message => '今日は$memberNameの番です';

  @override
  String toString() {
    return 'RotationNotification(id: $notificationId, time: $notificationTime, member: $memberName)';
  }
}
