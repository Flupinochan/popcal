/// 通知詳細情報（カレンダー表示用）
class NotificationDetail {
  final int notificationId;
  final DateTime date;
  final String memberName;
  final String title;
  final String body;

  const NotificationDetail({
    required this.notificationId,
    required this.date,
    required this.memberName,
    required this.title,
    required this.body,
  });

  @override
  String toString() {
    return 'NotificationDetail(id: $notificationId, date: $date, member: $memberName)';
  }
}
