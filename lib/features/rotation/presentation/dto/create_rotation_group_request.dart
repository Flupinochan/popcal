import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'create_rotation_group_request.freezed.dart';

@freezed
sealed class CreateRotationGroupRequest with _$CreateRotationGroupRequest {
  const CreateRotationGroupRequest._();

  const factory CreateRotationGroupRequest({
    required String userId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
  }) = _CreateRotationGroupRequest;

  /// DTO => Entity
  Result<RotationGroup> toEntity() {
    try {
      final currentTime = DateTime.now().toLocal();

      return Results.success(
        RotationGroup(
          rotationGroupId: null, // 作成時は未設定
          userId: userId,
          rotationName: rotationName,
          rotationMembers: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          currentRotationIndex: 0, // 作成時は0
          createdAt: currentTime,
          updatedAt: currentTime,
        ),
      );
    } catch (error) {
      return Results.failure(
        ValidationFailure(
          'CreateRotationGroupDto to RotationGroup conversion failed: $error',
        ),
      );
    }
  }

  /// Entity => DTO
  factory CreateRotationGroupRequest.fromEntity(RotationGroup entity) {
    return CreateRotationGroupRequest(
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
    );
  }
}
