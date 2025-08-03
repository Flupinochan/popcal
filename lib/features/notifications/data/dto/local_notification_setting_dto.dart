import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

part 'local_notification_setting_dto.freezed.dart';
part 'local_notification_setting_dto.g.dart';

@freezed
sealed class LocalNotificationSettingDto with _$LocalNotificationSettingDto {
  const LocalNotificationSettingDto._();

  const factory LocalNotificationSettingDto({
    required int notificationId,
    required String rotationGroupId,
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
  static Result<LocalNotificationSettingDto> fromEntity(
    NotificationSetting notification,
  ) {
    try {
      return Results.success(
        LocalNotificationSettingDto(
          notificationId: notification.notificationId,
          rotationGroupId: notification.rotationGroupId,
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
          rotationGroupId: rotationGroupId,
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
  factory LocalNotificationSettingDto.fromJson(Map<String, dynamic> json) =>
      _$LocalNotificationSettingDtoFromJson(json);

  // JSON => DTO
  static Result<LocalNotificationSettingDto> fromJsonSafe(
    Map<String, dynamic> json,
  ) {
    try {
      final dto = LocalNotificationSettingDto.fromJson(json);
      return Results.success(dto);
    } catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }
}

extension LocalNotificationSettingDtoJsonX on LocalNotificationSettingDto {
  // DTO => String(JSON)
  String toJsonString() => jsonEncode(toJson());

  // String(JSON) => DTO
  static Result<LocalNotificationSettingDto> fromJsonStringSafe(
    String jsonString,
  ) {
    try {
      final Map<String, dynamic> map =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return LocalNotificationSettingDto.fromJsonSafe(map);
    } catch (e) {
      return Results.failure(
        ValidationFailure('JSON string parsing failed: $e'),
      );
    }
  }

  // String(JSON) => DTO
  static LocalNotificationSettingDto fromJsonString(String jsonString) {
    final Map<String, dynamic> map =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return LocalNotificationSettingDto.fromJson(map);
  }
}
