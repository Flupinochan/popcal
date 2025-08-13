import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/entities/skip_event.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';

part 'rotation_response.freezed.dart';

@freezed
sealed class RotationResponse with _$RotationResponse {
  const factory RotationResponse({
    required RotationId rotationId,
    required UserId userId,
    required RotationName rotationName,
    required List<RotationMemberName> rotationMembers,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationIndex currentRotationIndex,
    required RotationCreatedAt createdAt,
    required RotationUpdatedAt updatedAt,
    required List<SkipEvent> skipEvents,
    required String displayDays,
    required String displayMembers,
    required String displayNotificationTime,
    required bool canSkipPrevious,
  }) = _RotationResponse;

  /// Entity => DTO
  factory RotationResponse.fromEntity(Rotation entity) {
    return RotationResponse(
      rotationId: entity.rotationId!,
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMemberNames,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      currentRotationIndex: entity.currentRotationIndex,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      skipEvents: entity.skipEvents,
      displayDays: entity.displayDays,
      displayMembers: entity.displayMembers,
      displayNotificationTime: entity.displayNotificationTime,
      canSkipPrevious: entity.canSkipPrevious(),
    );
  }
  const RotationResponse._();

  /// DTO => Entity
  Result<Rotation> toEntity() {
    return Results.success(
      Rotation(
        rotationId: rotationId,
        userId: userId,
        rotationName: rotationName,
        rotationMemberNames: rotationMembers,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        currentRotationIndex: currentRotationIndex,
        createdAt: createdAt,
        updatedAt: updatedAt,
        skipEvents: skipEvents,
      ),
    );
  }
}
