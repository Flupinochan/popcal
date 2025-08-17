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
    if (userIdResult.isFailure) {
      return Results.failure(ValidationFailure(userIdResult.displayText));
    }

    final rotationNameResult = RotationName.create(rotationName);
    if (rotationNameResult.isFailure) {
      return Results.failure(ValidationFailure(rotationNameResult.displayText));
    }

    final rotationMembersResult = RotationMemberNames.create(rotationMembers);
    if (rotationMembersResult.isFailure) {
      return Results.failure(
        ValidationFailure(rotationMembersResult.displayText),
      );
    }

    final rotationDaysResult = RotationDays.create(rotationDays);
    if (rotationDaysResult.isFailure) {
      return Results.failure(ValidationFailure(rotationDaysResult.displayText));
    }

    // 時刻入力はデフォルト値があり、未入力にできないため、バリデーション無し
    final notificationTimeResult = NotificationTime.fromTimeOfDay(
      notificationTime,
    );

    // Create時はRotationIdは不要
    return Results.success(
      Rotation(
        userId: userIdResult.valueOrNull!,
        rotationName: rotationNameResult.valueOrNull!,
        rotationMemberNames: rotationMembersResult.valueOrNull!,
        rotationDays: rotationDaysResult.valueOrNull!,
        notificationTime: notificationTimeResult,
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(currentTime),
        updatedAt: RotationUpdatedAt(currentTime),
        skipEvents: skipEvents,
      ),
    );
  }
}
