import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

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
}
