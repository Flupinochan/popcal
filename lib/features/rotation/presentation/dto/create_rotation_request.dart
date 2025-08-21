import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'create_rotation_request.freezed.dart';

@freezed
sealed class CreateRotationRequest with _$CreateRotationRequest {
  const factory CreateRotationRequest({
    required String userId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required SkipEvents skipEvents,
  }) = _CreateRotationRequest;

  const CreateRotationRequest._();

  /// DTO => Entity
  Result<Rotation> toEntity({required DateTime currentTime}) {
    final userIdResult = UserId.create(userId);
    if (userIdResult.isError) {
      return Result.error(userIdResult.error);
    }

    final rotationNameResult = RotationName.create(rotationName);
    if (rotationNameResult.isError) {
      return Result.error(rotationNameResult.error);
    }

    final rotationMemberNamesResult = RotationMemberNames.create(
      rotationMembers,
    );
    if (rotationMemberNamesResult.isError) {
      return Result.error(rotationMemberNamesResult.error);
    }

    final rotationDaysResult = RotationDays.create(rotationDays);
    if (rotationDaysResult.isError) {
      return Result.error(rotationDaysResult.error);
    }

    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );

    final rotationResult = Rotation.create(
      userId: userIdResult.value,
      rotationName: rotationNameResult.value,
      rotationMemberNames: rotationMemberNamesResult.value,
      rotationDays: rotationDaysResult.value,
      notificationTime: notificationTimeResult,
      skipEvents: skipEvents,
      currentTime: currentTime,
    );
    if (rotationResult.isError) {
      return Result.error(rotationResult.error);
    }

    return Result.ok(rotationResult.value);
  }
}
