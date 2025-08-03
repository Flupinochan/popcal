import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';

part 'notification_payload_dto.freezed.dart';
part 'notification_payload_dto.g.dart';

/// 通知情報
/// ※ポップアップに含まれるペイロード情報を定義
@freezed
sealed class NotificationPayloadDto with _$NotificationPayloadDto {
  const NotificationPayloadDto._();

  const factory NotificationPayloadDto({
    required int notificationId,
    required String rotationGroupId,
    required String userId,
    required String rotationName,
    required DateTime notificationTime,
    required String memberName,
    required DateTime rotationStartDate,
  }) = _NotificationPayloadDto;

  // Entity => DTO
  factory NotificationPayloadDto.fromEntity(NotificationSetting notification) {
    return NotificationPayloadDto(
      notificationId: notification.notificationId,
      rotationGroupId: notification.rotationGroupId,
      userId: notification.userId,
      rotationName: notification.rotationName,
      notificationTime: notification.notificationTime,
      memberName: notification.memberName,
      rotationStartDate: notification.rotationStartDate,
    );
  }

  // JSON => DTO
  factory NotificationPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadDtoFromJson(json);

  // DTO => JSON は自動生成
}

extension NotificationPayloadDtoJsonX on NotificationPayloadDto {
  // DTO => String(JSON)
  String toJsonString() => jsonEncode(toJson());

  // String(JSON) => DTO
  static NotificationPayloadDto fromJsonString(String jsonString) {
    final Map<String, dynamic> map =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return NotificationPayloadDto.fromJson(map);
  }
}
