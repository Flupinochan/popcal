import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_content.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_description.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_title.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';

part 'notification_entry_local_response.freezed.dart';
part 'notification_entry_local_response.g.dart';

@freezed
sealed class NotificationEntryLocalResponse
    with _$NotificationEntryLocalResponse {
  const factory NotificationEntryLocalResponse({
    // extentionTypeの場合は、@でJsonConverterへのマッピング定義が必要
    @NotificationIdConverter() required NotificationId notificationId,
    required SourceId sourceId,
    required UserId userId,
    @NotificationDateConverter()
    required NotificationDateTime notificationDateTime,
    required NotificationTitle title,
    required NotificationContent content,
    required NotificationDescription description,
  }) = _NotificationEntryLocalResponse;

  // JSON => DTO
  factory NotificationEntryLocalResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntryLocalResponseFromJson(json);
  const NotificationEntryLocalResponse._();

  // DTO => Entity
  NotificationEntry toEntity() {
    return NotificationEntry(
      notificationId: notificationId,
      sourceId: sourceId,
      userId: userId,
      notificationDateTime: notificationDateTime,
      title: title,
      content: content,
      description: description,
    );
  }

  // Entity => DTO
  static Result<NotificationEntryLocalResponse> fromEntity(
    NotificationEntry notification,
  ) {
    try {
      return Results.success(
        NotificationEntryLocalResponse(
          notificationId: notification.notificationId,
          sourceId: notification.sourceId,
          userId: notification.userId,
          notificationDateTime: notification.notificationDateTime,
          title: notification.title,
          content: notification.content,
          description: notification.description,
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
