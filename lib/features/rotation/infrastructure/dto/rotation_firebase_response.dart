import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
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
    if (rotationIdResult.isFailure) {
      return Results.failure(ValidationFailure(rotationIdResult.displayText));
    }

    final userIdResult = UserId.create(userId);
    if (userIdResult.isFailure) {
      return Results.failure(ValidationFailure(userIdResult.displayText));
    }

    final rotationNameResult = RotationName.create(rotationName);
    if (rotationNameResult.isFailure) {
      return Results.failure(ValidationFailure(rotationNameResult.displayText));
    }

    final rotationMemberNamesResult = RotationMemberNames.create(
      rotationMemberNames,
    );
    if (rotationMemberNamesResult.isFailure) {
      return Results.failure(
        ValidationFailure(rotationMemberNamesResult.displayText),
      );
    }

    final rotationDaysResult = RotationDays.create(rotationDays);
    if (rotationDaysResult.isFailure) {
      return Results.failure(ValidationFailure(rotationDaysResult.displayText));
    }

    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );

    final currentRotationIndexResult = RotationIndex.createFromInt(
      currentRotationIndex,
    );
    if (currentRotationIndexResult.isFailure) {
      return Results.failure(
        ValidationFailure(currentRotationIndexResult.displayText),
      );
    }

    final createdAtResult = RotationCreatedAt.create(createdAt);
    if (createdAtResult.isFailure) {
      return Results.failure(ValidationFailure(createdAtResult.displayText));
    }

    final updatedAtResult = RotationUpdatedAt.create(updatedAt);
    if (updatedAtResult.isFailure) {
      return Results.failure(ValidationFailure(updatedAtResult.displayText));
    }

    return Results.success(
      Rotation(
        rotationId: rotationIdResult.valueOrNull,
        userId: userIdResult.valueOrNull!,
        rotationName: rotationNameResult.valueOrNull!,
        rotationMemberNames: rotationMemberNamesResult.valueOrNull!,
        rotationDays: rotationDaysResult.valueOrNull!,
        notificationTime: notificationTimeResult,
        currentRotationIndex: currentRotationIndexResult.valueOrNull!,
        createdAt: createdAtResult.valueOrNull!,
        updatedAt: updatedAtResult.valueOrNull!,
        skipEvents: skipEvents,
      ),
    );
  }
}
