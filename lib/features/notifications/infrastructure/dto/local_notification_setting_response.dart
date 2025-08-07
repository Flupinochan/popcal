import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

part 'local_notification_setting_dto.freezed.dart';
part 'local_notification_setting_dto.g.dart';

@freezed
sealed class LocalNotificationSettingResponse
    with _$LocalNotificationSettingDto {
  const LocalNotificationSettingResponse._();

  const factory LocalNotificationSettingResponse({
    required int notificationId,
    required String rotationId,
    required String userId,
    required String rotationName,
    required DateTime notificationTime,
    required String memberName,
    required DateTime rotationStartDate,
    required String title,
    required String description,
    required String content,
  }) = _LocalNotificationSettingDto;

  // Entity => DTO
  static Result<LocalNotificationSettingResponse> fromEntity(
    NotificationSetting notification,
  ) {
    try {
      return Results.success(
        LocalNotificationSettingResponse(
          notificationId: notification.notificationId,
          rotationId: notification.rotationId,
          userId: notification.userId,
          rotationName: notification.rotationName,
          notificationTime: notification.notificationTime,
          memberName: notification.memberName,
          rotationStartDate: notification.rotationStartDate,
          title: notification.title,
          description: notification.description,
          content: notification.content,
        ),
      );
    } catch (e) {
      return Results.failure(
        ValidationFailure('NotificationSetting to DTO conversion failed: $e'),
      );
    }
  }

  // DTO => Entity
  Result<NotificationSetting> toEntity() {
    try {
      return Results.success(
        NotificationSetting(
          notificationId: notificationId,
          rotationId: rotationId,
          userId: userId,
          rotationName: rotationName,
          notificationTime: notificationTime,
          memberName: memberName,
          rotationStartDate: rotationStartDate,
        ),
      );
    } catch (e) {
      return Results.failure(
        ValidationFailure('DTO to NotificationSetting conversion failed: $e'),
      );
    }
  }

  // JSON => DTO
  factory LocalNotificationSettingResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$LocalNotificationSettingDtoFromJson(json);

  // JSON => DTO
  static Result<LocalNotificationSettingResponse> fromJsonSafe(
    Map<String, dynamic> json,
  ) {
    try {
      final dto = LocalNotificationSettingResponse.fromJson(json);
      return Results.success(dto);
    } catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }
}

extension LocalNotificationSettingDtoJsonX on LocalNotificationSettingResponse {
  // DTO => String(JSON)
  String toJsonString() => jsonEncode(toJson());

  // String(JSON) => DTO
  static Result<LocalNotificationSettingResponse> fromJsonStringSafe(
    String jsonString,
  ) {
    try {
      final Map<String, dynamic> map =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return LocalNotificationSettingResponse.fromJsonSafe(map);
    } catch (e) {
      return Results.failure(
        ValidationFailure('JSON string parsing failed: $e'),
      );
    }
  }

  // String(JSON) => DTO
  static LocalNotificationSettingResponse fromJsonString(String jsonString) {
    final Map<String, dynamic> map =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return LocalNotificationSettingResponse.fromJson(map);
  }
}
