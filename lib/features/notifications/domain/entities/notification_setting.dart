import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_content.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_description.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_title.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

part 'notification_setting.freezed.dart';

@freezed
sealed class NotificationSetting with _$NotificationSetting {
  const factory NotificationSetting({
    required NotificationId notificationId,
    // GroupIdはポップアップ通知をタップした際のカレンダー画面遷移で必要
    required GroupId groupId,
    required NotificationDateTime notificationDateTime,
    required NotificationTitle title,
    required NotificationContent content,
    required NotificationDescription description,
  }) = _NotificationSetting;

  const NotificationSetting._();

  String get displayTime => notificationDateTime.getDisplayDeadline();
}
