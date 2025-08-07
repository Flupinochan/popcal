// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalNotificationSettingDto _$LocalNotificationSettingDtoFromJson(
  Map<String, dynamic> json,
) => _LocalNotificationSettingDto(
  notificationId: (json['notificationId'] as num).toInt(),
  rotationId: json['rotationGroupId'] as String,
  userId: json['userId'] as String,
  rotationName: json['rotationName'] as String,
  notificationTime: DateTime.parse(json['notificationTime'] as String),
  memberName: json['memberName'] as String,
  rotationStartDate: DateTime.parse(json['rotationStartDate'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$LocalNotificationSettingDtoToJson(
  _LocalNotificationSettingDto instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'rotationGroupId': instance.rotationId,
  'userId': instance.userId,
  'rotationName': instance.rotationName,
  'notificationTime': instance.notificationTime.toIso8601String(),
  'memberName': instance.memberName,
  'rotationStartDate': instance.rotationStartDate.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'content': instance.content,
};
