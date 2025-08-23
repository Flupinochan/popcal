import 'package:flutter/material.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

class MockNotificationTime {
  static final NotificationTime notificationTime =
      NotificationTime.fromTimeOfDay(const TimeOfDay(hour: 15, minute: 0));
}
