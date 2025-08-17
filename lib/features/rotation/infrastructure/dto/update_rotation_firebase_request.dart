import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'update_rotation_firebase_request.freezed.dart';

@freezed
sealed class UpdateRotationFirebaseRequest
    with _$UpdateRotationFirebaseRequest {
  // EnumはMapperでintやStringに変換
  const factory UpdateRotationFirebaseRequest({
    required String rotationName,
    required List<String> rotationMemberNames,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SkipEvents skipEvents,
    required String userId,
    required String rotationId,
  }) = _UpdateRotationFirebaseRequest;

  const UpdateRotationFirebaseRequest._();

  // Create/Update共通はよくない。Create時のみrotationIdはoptional
  static Result<UpdateRotationFirebaseRequest> fromEntity(Rotation rotation) {
    if (!rotation.isRotationIdExist) {
      return Results.failure(
        const RotationFailure('ローテーショングループ更新時にRotationIdは必須です'),
      );
    }

    return Results.success(
      UpdateRotationFirebaseRequest(
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
      ),
    );
  }
}
