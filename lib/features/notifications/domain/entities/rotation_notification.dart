/// 各通知設定
class RotationNotification {
  final int notificationId;
  final String rotationGroupId;
  final String ownerUserId;
  // 通知名
  final String rotationName;
  // 通知日時
  final DateTime notificationTime;
  // 通知メンバー
  final String memberName;
  final DateTime rotationStartDate;

  const RotationNotification({
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
  String get message => '今日は${memberName}の番です';

  /// 通知日（日付のみ）
  DateTime get notificationDate => DateTime(
    notificationTime.year,
    notificationTime.month,
    notificationTime.day,
  );

  /// 過去の通知かどうか
  bool get isPast => notificationTime.isBefore(DateTime.now().toLocal());

  /// 今日の通知かどうか
  bool get isToday {
    final now = DateTime.now().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    return notificationDate == today;
  }

  @override
  String toString() {
    return 'RotationNotification(id: $notificationId, time: $notificationTime, member: $memberName)';
  }
}
