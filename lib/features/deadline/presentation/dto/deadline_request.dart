import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

part 'deadline_request.freezed.dart';

// Deadline設定用Request/Response共通
@freezed
sealed class DeadlineRequest with _$DeadlineRequest {
  factory DeadlineRequest({
    required bool isEnabled,
    required TimeOfDay notificationTime,
  }) = _DeadlineRequest;

  const DeadlineRequest._();

  Deadline toEntity() {
    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );
    return Deadline(
      isEnabled: isEnabled,
      notificationTime: notificationTimeResult,
    );
  }
}
