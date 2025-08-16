import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

class Deadline {
  const Deadline({required this.isEnabled, required this.notificationTime});

  final bool isEnabled;
  final NotificationTime notificationTime;

  Deadline copyWith({
    bool? isEnabled,
    NotificationTime? notificationTime,
  }) {
    return Deadline(
      isEnabled: isEnabled ?? this.isEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  // 通知のon/offを切り替え
  Deadline toggle() {
    return copyWith(isEnabled: !isEnabled);
  }
}
