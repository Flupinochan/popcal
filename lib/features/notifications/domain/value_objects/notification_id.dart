import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

extension type NotificationId._(int value) {
  factory NotificationId.create(SourceId sourceId, DateTime date) {
    final combined = '$sourceId-${date.year}-${date.month}-${date.day}';
    return NotificationId._(combined.hashCode.abs() % 2147483647);
  }

  factory NotificationId.createFromLocal(int value) {
    return NotificationId._(value);
  }
}
