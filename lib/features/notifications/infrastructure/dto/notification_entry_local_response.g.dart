// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entry_local_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationEntryLocalResponse _$NotificationEntryLocalResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationEntryLocalResponse(
  notificationId: (json['notificationId'] as num).toInt(),
  rotationId: json['rotationId'] as String,
  userId: UserId.fromJson(json['userId'] as String),
  rotationName: json['rotationName'] as String,
  notificationTime: DateTime.parse(json['notificationTime'] as String),
  memberName: json['memberName'] as String,
  rotationStartDate: DateTime.parse(json['rotationStartDate'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$NotificationEntryLocalResponseToJson(
  _NotificationEntryLocalResponse instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'rotationId': instance.rotationId,
  'userId': instance.userId,
  'rotationName': instance.rotationName,
  'notificationTime': instance.notificationTime.toIso8601String(),
  'memberName': instance.memberName,
  'rotationStartDate': instance.rotationStartDate.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'content': instance.content,
};
