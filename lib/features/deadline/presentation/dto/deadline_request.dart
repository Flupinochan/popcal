import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

part 'deadline_request.freezed.dart';

/// request/response共通
@freezed
sealed class DeadlineRequest with _$DeadlineRequest {
  factory DeadlineRequest({
    required bool isEnabled,
    required NotificationTime notificationTime,
  }) = _DeadlineRequest;

  const DeadlineRequest._();

  Deadline toEntity() =>
      Deadline(isEnabled: isEnabled, notificationTime: notificationTime);
}
