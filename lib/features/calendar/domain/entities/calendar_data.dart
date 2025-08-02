import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:table_calendar/table_calendar.dart';

// カレンダー表示用データおよびロジック
class CalendarData {
  final AppUser appUser;
  final RotationGroup rotationGroup;
  final List<NotificationDetail> notificationDetails;

  const CalendarData({
    required this.appUser,
    required this.rotationGroup,
    required this.notificationDetails,
  });

  // 指定日の通知情報を取得
  // 通知日でなく通知情報がない場合はnullを返却
  NotificationDetail? getNotificationForDate(DateTime date) {
    final matches = notificationDetails.where(
      (detail) => isSameDay(detail.date, date),
    );
    return matches.isNotEmpty ? matches.first : null;
  }

  /// 指定日の担当者名を取得
  String? getMemberNameForDate(DateTime date) {
    final notification = getNotificationForDate(date);
    if (notification == null) {
      return null;
    }
    return notification.memberName;
  }

  /// 指定日がローテーション日かどうか
  bool isRotationDay(DateTime date) {
    final notification = getNotificationForDate(date);
    return notification != null && notification.memberName.isNotEmpty;
  }
}
