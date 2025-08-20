import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
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

    final rotationMembersResult = RotationMemberNames.create(rotationMembers);
    if (rotationMembersResult.isError) {
      return Result.error(rotationMembersResult.error);
    }

    final rotationDaysResult = RotationDays.create(rotationDays);
    if (rotationDaysResult.isError) {
      return Result.error(rotationDaysResult.error);
    }

    // 時刻入力はデフォルト値があり、未入力にできないため、バリデーション無し
    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );

    final createdAtResult = RotationCreatedAt.create(currentTime);
    if (createdAtResult.isError) {
      return Result.error(createdAtResult.error);
    }

    final updatedAtResult = RotationUpdatedAt.create(currentTime);
    if (updatedAtResult.isError) {
      return Result.error(updatedAtResult.error);
    }

    // Create時はRotationIdは不要
    return Result.ok(
      Rotation(
        userId: userIdResult.value,
        rotationName: rotationNameResult.value,
        rotationMemberNames: rotationMembersResult.value,
        rotationDays: rotationDaysResult.value,
        notificationTime: notificationTimeResult,
        currentRotationIndex: RotationIndex(),
        createdAt: createdAtResult.value,
        updatedAt: updatedAtResult.value,
        skipEvents: skipEvents,
      ),
    );
  }
}
