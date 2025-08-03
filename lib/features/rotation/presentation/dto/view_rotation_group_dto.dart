import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'view_rotation_group_dto.freezed.dart';

@freezed
sealed class ViewRotationGroupDto with _$ViewRotationGroupDto {
  const ViewRotationGroupDto._();

  const factory ViewRotationGroupDto({
    required String rotationGroupId,
    required String userId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ViewRotationGroupDto;

  /// Entity => DTO
  factory ViewRotationGroupDto.fromEntity(RotationGroup entity) {
    return ViewRotationGroupDto(
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
}

// UI表示用の拡張メソッド
extension RotationGroupViewDtoDisplay on ViewRotationGroupDto {
  String get membersDisplay => rotationMembers.join(', ');
  String get weekdaysDisplay =>
      rotationDays.map((w) => w.displayName).join(', ');
  String get timeDisplay =>
      '${notificationTime.hour.toString().padLeft(2, '0')}:${notificationTime.minute.toString().padLeft(2, '0')}';

  String get createdAtDisplay {
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }
}
