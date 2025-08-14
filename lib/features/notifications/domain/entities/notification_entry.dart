import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

/// 各通知設定
class NotificationEntry {
  const NotificationEntry({
    required this.notificationId,
    required this.rotationId,
    required this.userId,
    required this.rotationName,
    required this.notificationDateTime,
    required this.memberName,
  });

  final NotificationId notificationId;
  // rotationIdはポップアップをタップした際に、カレンダー画面を表示するために必要
  final RotationId rotationId;
  final UserId userId;
  final NotificationDateTime notificationDateTime;
  final RotationName rotationName;
  final RotationMemberName memberName;

  /// ポップアップ通知で表示する内容
  String get content => '今日は${memberName.value}の番です';
  String get description => '${rotationName.value}の通知';
  String get title => rotationName.value;
}
