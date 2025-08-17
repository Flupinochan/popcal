import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'rotation_firebase_request.freezed.dart';

@freezed
sealed class RotationFirebaseRequest with _$RotationFirebaseRequest {
  const factory RotationFirebaseRequest({
    required String? rotationId,
    required String userId,
    required String rotationName,
    required List<String> rotationMemberNames,
    // EnumはMapperでintやStringに変換
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SkipEvents skipEvents,
  }) = _RotationFirebaseRequest;

  factory RotationFirebaseRequest.fromEntity(Rotation rotation) {
    return RotationFirebaseRequest(
      rotationId: rotation.rotationId!.value,
      userId: rotation.userId.value,
      rotationName: rotation.rotationName.value,
      rotationMemberNames:
          rotation.rotationMemberNames
              .map((rotationMember) => rotationMember.value)
              .toList(),
      rotationDays:
          rotation.rotationDays.map((weekday) => weekday.value).toList(),
      notificationTime: rotation.notificationTime.timeOfDay,
      currentRotationIndex: rotation.currentRotationIndex.value,
      createdAt: rotation.createdAt.value,
      updatedAt: rotation.updatedAt.value,
      skipEvents: rotation.skipEvents,
    );
  }

  const RotationFirebaseRequest._();
}
