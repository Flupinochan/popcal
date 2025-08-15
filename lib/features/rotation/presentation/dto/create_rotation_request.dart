import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

part 'create_rotation_request.freezed.dart';

@freezed
sealed class CreateRotationRequest with _$CreateRotationRequest {
  const factory CreateRotationRequest({
    required UserId userId,
    required RotationName rotationName,
    required RotationMemberNames rotationMembers,
    required RotationDays rotationDays,
    required NotificationTime notificationTime,
    required List<SkipEvent> skipEvents,
  }) = _CreateRotationRequest;

  /// Entity => DTO
  factory CreateRotationRequest.fromEntity(Rotation entity) {
    return CreateRotationRequest(
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMemberNames,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      skipEvents: entity.skipEvents,
    );
  }
  const CreateRotationRequest._();

  /// DTO => Entity
  Result<Rotation> toEntity({required DateTime currentTime}) {
    try {
      return Results.success(
        Rotation(
          userId: userId,
          rotationName: rotationName,
          rotationMemberNames: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          currentRotationIndex: const RotationIndex(0),
          createdAt: RotationCreatedAt(currentTime),
          updatedAt: RotationUpdatedAt(currentTime),
          skipEvents: skipEvents,
        ),
      );
    } on Exception catch (error) {
      return Results.failure(
        ValidationFailure(
          'CreateRotation to Rotation conversion failed: $error',
        ),
      );
    }
  }
}
