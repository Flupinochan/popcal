import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
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

  // DTO => Entity
  Result<Rotation> toEntity({required DateTime currentTime}) {
    final userIdResult = UserId.create(userId);
    if (userIdResult.isError) {
      return Result.error(userIdResult.error);
    }

    final rotationIdResult = RotationId.create(rotationId);
    if (rotationIdResult.isError) {
      return Result.error(rotationIdResult.error);
    }

    final rotationNameResult = RotationName.create(rotationName);
    if (rotationNameResult.isError) {
      return Result.error(rotationNameResult.error);
    }

    final rotationMembersResult = RotationMemberNames.create(rotationMembers);
    if (rotationMembersResult.isError) {
      return Result.error(rotationMembersResult.error);
    }

    final rotationDaysResult = RotationDays.create(rotationDays);
    if (rotationDaysResult.isError) {
      return Result.error(rotationDaysResult.error);
    }

    // 時刻入力はデフォルト値があり、未入力にできないため、バリデーション不要
    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );

    final createdAtResult = RotationCreatedAt.create(createdAt);
    if (createdAtResult.isError) {
      return Result.error(createdAtResult.error);
    }

    return Result.ok(
      Rotation(
        rotationId: rotationIdResult.value,
        userId: userIdResult.value,
        rotationName: rotationNameResult.value,
        rotationMemberNames: rotationMembersResult.value,
        rotationDays: rotationDaysResult.value,
        notificationTime: notificationTimeResult,
        currentRotationIndex: RotationIndex(),
        createdAt: createdAtResult.value,
        updatedAt: RotationUpdatedAt.now(),
        skipEvents: skipEvents,
      ),
    );
  }
}
