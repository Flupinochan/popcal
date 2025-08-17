import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'rotation_response.freezed.dart';

@freezed
sealed class RotationResponse with _$RotationResponse {
  const factory RotationResponse({
    required String rotationId,
    required String userId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SkipEvents skipEvents,
    required String displayDays,
    required String displayMembers,
    required String displayNotificationTime,
  }) = _RotationResponse;

  factory RotationResponse.fromEntity(Rotation entity) {
    return RotationResponse(
      rotationId: entity.rotationId!.value,
      userId: entity.userId.value,
      rotationName: entity.rotationName.value,
      rotationMembers: entity.rotationMemberNames.value,
      rotationDays: entity.rotationDays.value,
      notificationTime: entity.notificationTime.timeOfDay,
      currentRotationIndex: entity.currentRotationIndex.value,
      createdAt: entity.createdAt.value,
      updatedAt: entity.updatedAt.value,
      skipEvents: entity.skipEvents,
      displayDays: entity.displayDays,
      displayMembers: entity.displayMembers,
      displayNotificationTime: entity.displayNotificationTime,
    );
  }

  const RotationResponse._();
}
