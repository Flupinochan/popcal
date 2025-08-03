import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'update_rotation_group_dto.freezed.dart';

@freezed
sealed class UpdateRotationGroupDto with _$UpdateRotationGroupDto {
  const UpdateRotationGroupDto._();

  const factory UpdateRotationGroupDto({
    required String userId,
    required String rotationGroupId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
  }) = _UpdateRotationGroupDto;

  // DTO => Entity
  Result<RotationGroup> applyToEntity(RotationGroup rotationGroup) {
    try {
      if (rotationGroup.userId != userId) {
        return Results.failure(AuthFailure('所有者が一致しません'));
      }
      if (rotationGroup.rotationGroupId != rotationGroupId) {
        return Results.failure(ValidationFailure('ローテーションIDが一致しません'));
      }

      final currentTime = DateTime.now().toLocal();

      return Results.success(
        rotationGroup.copyWith(
          rotationName: rotationName,
          rotationMembers: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          currentRotationIndex: 0, // 更新時はリセット
          updatedAt: currentTime,
          createdAt: currentTime,
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
  factory UpdateRotationGroupDto.fromEntity(RotationGroup entity) {
    return UpdateRotationGroupDto(
      userId: entity.userId,
      rotationGroupId: entity.rotationGroupId!,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
    );
  }
}
