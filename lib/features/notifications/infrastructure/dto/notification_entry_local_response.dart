import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
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
    required int notificationId,
    required String sourceId,
    required DateTime notificationDateTime,
    required String title,
    required String content,
    required String description,
  }) = _NotificationEntryLocalResponse;

  // JSON => DTO
  factory NotificationEntryLocalResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntryLocalResponseFromJson(json);

  const NotificationEntryLocalResponse._();

  // DTO => Entity
  Result<NotificationSetting> toEntity() {
    final sourceIdExt = GroupId.create(sourceId);
    final notificationIdExt = NotificationId.create(
      sourceIdExt,
      notificationDateTime,
    );

    final notificationDateTimeResult = NotificationDateTime.create(
      notificationDateTime,
    );
    if (notificationDateTimeResult.isError) {
      return Result.error(notificationDateTimeResult.error);
    }

    return Result.ok(
      NotificationSetting(
        notificationId: notificationIdExt,
        groupId: sourceIdExt,
        notificationDateTime: notificationDateTimeResult.value,
        title: NotificationTitle.createFromLocal(title),
        content: NotificationContent.createFromLocal(content),
        description: NotificationDescription.createFromLocal(description),
      ),
    );
  }

  // Entity => DTO
  static NotificationEntryLocalResponse fromEntity(
    NotificationSetting notification,
  ) {
    return NotificationEntryLocalResponse(
      notificationId: notification.notificationId.value,
      sourceId: notification.groupId.value,
      notificationDateTime: notification.notificationDateTime.value,
      title: notification.title.value,
      content: notification.content.value,
      description: notification.description.value,
    );
  }

  // JSON => DTO
  static Result<NotificationEntryLocalResponse> fromJsonSafe(
    Map<String, dynamic> json,
  ) {
    try {
      final dto = NotificationEntryLocalResponse.fromJson(json);
      return Result.ok(dto);
    } on Exception catch (e) {
      return Result.error(ValidationException('JSON parsing failed: $e'));
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
      return Result.error(
        ValidationException('JSON string parsing failed: $e'),
      );
    }
  }
}
