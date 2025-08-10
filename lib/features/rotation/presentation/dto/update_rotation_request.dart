import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/shared/utils/time_utils.dart';

part 'update_rotation_request.freezed.dart';

@freezed
sealed class UpdateRotationRequest with _$UpdateRotationRequest {
  const UpdateRotationRequest._();

  const factory UpdateRotationRequest({
    required UserId userId,
    required RotationId rotationId,
    required RotationName rotationName,
    required List<RotationMemberName> rotationMembers,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
    required RotationCreatedAt createdAt,
  }) = _UpdateRotationRequest;

  // DTO => Entity
  Result<Rotation> toEntity({required DateTime currentTime}) {
    try {
      return Results.success(
        Rotation(
          rotationId: rotationId,
          userId: userId,
          rotationName: rotationName,
          rotationMemberNames: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          currentRotationIndex: RotationIndex(0),
          createdAt: createdAt,
          updatedAt: RotationUpdatedAt(currentTime),
        ),
      );
    } catch (e) {
      return Results.failure(
        ValidationFailure('UpdateRotation to Rotation conversion failed: $e'),
      );
    }
  }

  /// Entity => DTO
  factory UpdateRotationRequest.fromEntity(Rotation entity) {
    return UpdateRotationRequest(
      rotationId: entity.rotationId!,
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMemberNames,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      createdAt: entity.createdAt,
    );
  }
}
