import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'update_rotation_group_request.freezed.dart';

@freezed
sealed class UpdateRotationGroupRequest with _$UpdateRotationGroupRequest {
  const UpdateRotationGroupRequest._();

  const factory UpdateRotationGroupRequest({
    required String userId,
    required String rotationGroupId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required DateTime createdAt,
  }) = _UpdateRotationGroupRequest;

  // DTO => Entity
  Result<RotationGroup> toEntity() {
    try {
      final currentTime = DateTime.now().toLocal();

      return Results.success(
        RotationGroup(
          userId: userId,
          rotationGroupId: rotationGroupId,
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
        ValidationFailure(
          'UpdateRotationGroupDto to RotationGroup conversion failed: $e',
        ),
      );
    }
  }

  /// Entity => DTO
  factory UpdateRotationGroupRequest.fromEntity(RotationGroup entity) {
    return UpdateRotationGroupRequest(
      userId: entity.userId,
      rotationGroupId: entity.rotationGroupId!,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      createdAt: entity.createdAt,
    );
  }
}
