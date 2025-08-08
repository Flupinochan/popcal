import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'rotation_response.freezed.dart';

@freezed
sealed class RotationResponse with _$RotationResponse {
  const RotationResponse._();

  const factory RotationResponse({
    required RotationId rotationId,
    required UserId userId,
    required RotationName rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RotationResponse;

  /// DTO => Entity
  Result<Rotation> toEntity() {
    return Results.success(
      Rotation(
        rotationId: rotationId,
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
  factory RotationResponse.fromEntity(Rotation entity) {
    return RotationResponse(
      rotationId: entity.rotationId!,
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
extension RotationViewDisplay on RotationResponse {
  String get membersDisplay => rotationMembers.join(', ');
  String get weekdaysDisplay =>
      rotationDays.map((w) => w.displayName).join(', ');
  String get timeDisplay =>
      '${notificationTime.hour.toString().padLeft(2, '0')}:${notificationTime.minute.toString().padLeft(2, '0')}';

  String get createdAtDisplay {
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }
}
