import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'notification_entry_local_response.freezed.dart';
part 'notification_entry_local_response.g.dart';

@freezed
sealed class NotificationEntryLocalResponse
    with _$NotificationEntryLocalResponse {
  const factory NotificationEntryLocalResponse({
    @NotificationIdConverter() required NotificationId notificationId,
    @RotationIdConverter() required RotationId rotationId,
    required UserId userId,
    @NotificationDateConverter() required NotificationDateTime notificationDate,
    @RotationNameConverter() required RotationName rotationName,
    @RotationMemberNameConverter() required RotationMemberName memberName,
    required String title,
    required String description,
    required String content,
  }) = _NotificationEntryLocalResponse;

  // JSON => DTO
  factory NotificationEntryLocalResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntryLocalResponseFromJson(json);
  const NotificationEntryLocalResponse._();

  // DTO => Entity
  Result<NotificationEntry> toEntity() {
    try {
      return Results.success(
        NotificationEntry(
          notificationId: notificationId,
          rotationId: rotationId,
          userId: userId,
          rotationName: rotationName,
          notificationDate: notificationDate,
          memberName: memberName,
        ),
      );
    } on Exception catch (e) {
      return Results.failure(
        ValidationFailure('DTO to NotificationSetting conversion failed: $e'),
      );
    }
  }

  // Entity => DTO
  static Result<NotificationEntryLocalResponse> fromEntity(
    NotificationEntry notification,
  ) {
    try {
      return Results.success(
        NotificationEntryLocalResponse(
          notificationId: notification.notificationId,
          rotationId: notification.rotationId,
          userId: notification.userId,
          notificationDate: notification.notificationDate,
          rotationName: notification.rotationName,
          memberName: notification.memberName,
          title: notification.title,
          description: notification.description,
          content: notification.content,
        ),
      );
    } on Exception catch (e) {
      return Results.failure(
        ValidationFailure('NotificationSetting to DTO conversion failed: $e'),
      );
    }
  }

  // JSON => DTO
  static Result<NotificationEntryLocalResponse> fromJsonSafe(
    Map<String, dynamic> json,
  ) {
    try {
      final dto = NotificationEntryLocalResponse.fromJson(json);
      return Results.success(dto);
    } on Exception catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }
}

extension LocalNotificationSettingDtoJsonX on NotificationEntryLocalResponse {
  // DTO => String(JSON)
  String toJsonString() => jsonEncode(toJson());

  // String(JSON) => DTO
  static NotificationEntryLocalResponse fromJsonString(String jsonString) {
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return NotificationEntryLocalResponse.fromJson(map);
  }

  // String(JSON) => DTO
  static Result<NotificationEntryLocalResponse> fromJsonStringSafe(
    String jsonString,
  ) {
    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return NotificationEntryLocalResponse.fromJsonSafe(map);
    } on Exception catch (e) {
      return Results.failure(
        ValidationFailure('JSON string parsing failed: $e'),
      );
    }
  }
}
