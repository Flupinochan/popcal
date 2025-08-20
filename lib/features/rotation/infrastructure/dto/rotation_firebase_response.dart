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

part 'rotation_firebase_response.freezed.dart';

@freezed
sealed class RotationFirebaseResponse with _$RotationFirebaseResponse {
  const factory RotationFirebaseResponse({
    required String rotationId,
    required String userId,
    required String rotationName,
    required List<String> rotationMemberNames,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SkipEvents skipEvents,
  }) = _RotationFirebaseResponse;

  const RotationFirebaseResponse._();

  Result<Rotation> toEntity() {
    final rotationIdResult = RotationId.create(rotationId);
    if (rotationIdResult.isError) {
      return Result.error(rotationIdResult.error);
    }

    final userIdResult = UserId.create(userId);
    if (userIdResult.isError) {
      return Result.error(userIdResult.error);
    }

    final rotationNameResult = RotationName.create(rotationName);
    if (rotationNameResult.isError) {
      return Result.error(rotationNameResult.error);
    }

    final rotationMemberNamesResult = RotationMemberNames.create(
      rotationMemberNames,
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

    final currentRotationIndexResult = RotationIndex.createFromInt(
      currentRotationIndex,
    );
    if (currentRotationIndexResult.isError) {
      return Result.error(currentRotationIndexResult.error);
    }

    final createdAtResult = RotationCreatedAt.create(createdAt);
    if (createdAtResult.isError) {
      return Result.error(createdAtResult.error);
    }

    final updatedAtResult = RotationUpdatedAt.create(updatedAt);
    if (updatedAtResult.isError) {
      return Result.error(updatedAtResult.error);
    }

    return Result.ok(
      Rotation(
        rotationId: rotationIdResult.value,
        userId: userIdResult.value,
        rotationName: rotationNameResult.value,
        rotationMemberNames: rotationMemberNamesResult.value,
        rotationDays: rotationDaysResult.value,
        notificationTime: notificationTimeResult,
        currentRotationIndex: currentRotationIndexResult.value,
        createdAt: createdAtResult.value,
        updatedAt: updatedAtResult.value,
        skipEvents: skipEvents,
      ),
    );
  }
}
