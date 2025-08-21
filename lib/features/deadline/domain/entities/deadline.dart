import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

part 'deadline.freezed.dart';

@freezed
sealed class Deadline with _$Deadline {
  const factory Deadline({
    required bool isEnabled,
    required NotificationTime notificationTime,
  }) = _Deadline;

  const Deadline._();
}
