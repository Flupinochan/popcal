import 'package:flutter/widgets.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/content.dart';
import 'package:popcal/features/notifications/domain/value_objects/description.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
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
  final SourceId sourceId;
  final UserId userId;
  final NotificationDateTime notificationDateTime;
  final Title title;
  final Content content;
  final Description description;

  // /// ポップアップ通知で表示する内容
  // String get content => '今日は${memberName.value}の番です';
  // String get description => '${rotationName.value}の通知';
  // String get title => rotationName.value;
}
