import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';

part 'create_rotation_request.freezed.dart';

@freezed
sealed class CreateRotationRequest with _$CreateRotationRequest {
  const CreateRotationRequest._();

  const factory CreateRotationRequest({
    required UserId userId,
    required RotationName rotationName,
    required List<RotationMemberName> rotationMembers,
    required List<Weekday> rotationDays,
    required NotificationTime notificationTime,
  }) = _CreateRotationRequest;

  /// DTO => Entity
  Result<Rotation> toEntity() {
    try {
      final currentTime = DateTime.now().toLocal();

      return Results.success(
        Rotation(
          rotationId: null, // 作成時は未設定
          userId: userId,
          rotationName: rotationName,
          rotationMemberNames: rotationMembers,
          rotationDays: rotationDays,
          notificationTime: notificationTime,
          currentRotationIndex: RotationIndex(0), // 作成時は0
          createdAt: RotationCreatedAt(currentTime),
          updatedAt: RotationUpdatedAt(currentTime),
        ),
      );
    } catch (error) {
      return Results.failure(
        ValidationFailure(
          'CreateRotation to Rotation conversion failed: $error',
        ),
      );
    }
  }

  /// Entity => DTO
  factory CreateRotationRequest.fromEntity(Rotation entity) {
    return CreateRotationRequest(
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMemberNames,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
    );
  }
}
