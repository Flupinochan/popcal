// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entry_local_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationEntryLocalResponse _$NotificationEntryLocalResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationEntryLocalResponse(
  notificationId: (json['notificationId'] as num).toInt(),
  sourceId: json['sourceId'] as String,
  userId: json['userId'] as String,
  notificationDateTime: DateTime.parse(json['notificationDateTime'] as String),
  title: json['title'] as String,
  content: json['content'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$NotificationEntryLocalResponseToJson(
  _NotificationEntryLocalResponse instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'sourceId': instance.sourceId,
  'userId': instance.userId,
  'notificationDateTime': instance.notificationDateTime.toIso8601String(),
  'title': instance.title,
  'content': instance.content,
  'description': instance.description,
};
