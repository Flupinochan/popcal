import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_date.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

/// 通知設定
class NotificationEntry {
  final int notificationId;
  // rotationIdはポップアップをタップした際に、カレンダー画面を表示するために必要
  final RotationId rotationId;
  final UserId userId;
  final NotificationDate notificationDate;
  final RotationName rotationName;
  final RotationMemberName memberName;

  const NotificationEntry({
    required this.notificationId,
    required this.rotationId,
    required this.userId,
    required this.rotationName,
    required this.notificationDate,
    required this.memberName,
  });

  String get title => rotationName.value;
  String get description => '${rotationName.value}の通知';
  String get content => '今日は${memberName.value}の番です';
}
