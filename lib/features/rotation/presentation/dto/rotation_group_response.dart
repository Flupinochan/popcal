import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'rotation_group_response.freezed.dart';

@freezed
sealed class RotationGroupResponse with _$RotationGroupResponse {
  const RotationGroupResponse._();

  const factory RotationGroupResponse({
    required String rotationGroupId,
    required String userId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RotationGroupResponse;

  /// DTO => Entity
  Result<RotationGroup> toEntity() {
    return Results.success(
      RotationGroup(
        rotationGroupId: rotationGroupId,
        userId: userId,
        rotationName: rotationName,
        rotationMembers: rotationMembers,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        currentRotationIndex: currentRotationIndex,
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    );
  }

  /// Entity => DTO
  factory RotationGroupResponse.fromEntity(RotationGroup entity) {
    return RotationGroupResponse(
      rotationGroupId: entity.rotationGroupId!,
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      currentRotationIndex: entity.currentRotationIndex,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

// UI表示用の拡張メソッド
extension RotationGroupViewDtoDisplay on RotationGroupResponse {
  String get membersDisplay => rotationMembers.join(', ');
  String get weekdaysDisplay =>
      rotationDays.map((w) => w.displayName).join(', ');
  String get timeDisplay =>
      '${notificationTime.hour.toString().padLeft(2, '0')}:${notificationTime.minute.toString().padLeft(2, '0')}';

  String get createdAtDisplay {
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }
}
