import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'update_rotation_request.freezed.dart';

@freezed
sealed class UpdateRotationRequest with _$UpdateRotationRequest {
  const UpdateRotationRequest._();

  const factory UpdateRotationRequest({
    required UserId userId,
    required RotationId rotationId,
    required RotationName rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime createdAt,
  }) = _UpdateRotationRequest;

  // DTO => Entity
  Result<Rotation> toEntity() {
    try {
      final currentTime = DateTime.now().toLocal();

      return Results.success(
        Rotation(
          userId: userId,
          rotationId: rotationId,
          rotationName: rotationName,
          rotationMembers: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          createdAt: createdAt,
          updatedAt: currentTime,
          currentRotationIndex: 0, // 更新時は0にリセット
        ),
      );
    } catch (e) {
      return Results.failure(
        ValidationFailure('UpdateRotation to Rotation conversion failed: $e'),
      );
    }
  }

  /// Entity => DTO
  factory UpdateRotationRequest.fromEntity(Rotation entity) {
    return UpdateRotationRequest(
      userId: entity.userId,
      rotationId: entity.rotationId!,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      createdAt: entity.createdAt,
    );
  }
}
