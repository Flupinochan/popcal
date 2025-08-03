// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPayloadDto _$NotificationPayloadDtoFromJson(
  Map<String, dynamic> json,
) => _NotificationPayloadDto(
  notificationId: (json['notificationId'] as num).toInt(),
  rotationGroupId: json['rotationGroupId'] as String,
  userId: json['userId'] as String,
  rotationName: json['rotationName'] as String,
  notificationTime: DateTime.parse(json['notificationTime'] as String),
  memberName: json['memberName'] as String,
  rotationStartDate: DateTime.parse(json['rotationStartDate'] as String),
);

Map<String, dynamic> _$NotificationPayloadDtoToJson(
  _NotificationPayloadDto instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'rotationGroupId': instance.rotationGroupId,
  'userId': instance.userId,
  'rotationName': instance.rotationName,
  'notificationTime': instance.notificationTime.toIso8601String(),
  'memberName': instance.memberName,
  'rotationStartDate': instance.rotationStartDate.toIso8601String(),
};
