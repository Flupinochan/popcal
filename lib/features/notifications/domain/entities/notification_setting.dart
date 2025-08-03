/// 通知設定
class NotificationSetting {
  final int notificationId;
  // rotationGroupIdはポップアップをタップした際に、カレンダー画面を表示するさいに必要
  final String rotationGroupId;
  final String userId;
  // 以下ポップアップの通知情報
  final String rotationName;
  final DateTime notificationTime;
  final String memberName;
  final DateTime rotationStartDate;

  const NotificationSetting({
    required this.notificationId,
    required this.rotationGroupId,
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
