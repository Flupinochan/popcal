import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_content.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_description.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_title.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

/// 各通知設定
class NotificationEntry {
  const NotificationEntry({
    required this.notificationId,
    required this.sourceId,
    required this.userId,
    required this.notificationDateTime,
    required this.title,
    required this.content,
    required this.description,
  });

  final NotificationId notificationId;
  // sourceIdはポップアップをタップした際に、カレンダー画面を表示(画面遷移)するために必要
  // sourceIdはrotationIdなどの通知グループの役割
  final SourceId sourceId;
  final UserId userId;
  final NotificationDateTime notificationDateTime;
  final NotificationTitle title;
  final NotificationContent content;
  final NotificationDescription description;

  String get displayTime => notificationDateTime.getDisplayDeadline();
}
