import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'update_rotation_request.freezed.dart';

@freezed
sealed class UpdateRotationRequest with _$UpdateRotationRequest {
  const factory UpdateRotationRequest({
    required String userId,
    required String rotationId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime createdAt,
    required SkipEvents skipEvents,
  }) = _UpdateRotationRequest;

  const UpdateRotationRequest._();
}
