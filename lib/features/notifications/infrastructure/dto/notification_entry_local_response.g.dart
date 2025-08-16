// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entry_local_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationEntryLocalResponse _$NotificationEntryLocalResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationEntryLocalResponse(
  notificationId: const NotificationIdConverter().fromJson(
    (json['notificationId'] as num).toInt(),
  ),
  sourceId: SourceId.fromJson(json['sourceId'] as Map<String, dynamic>),
  userId: UserId.fromJson(json['userId'] as String),
  notificationDateTime: const NotificationDateConverter().fromJson(
    json['notificationDateTime'] as String,
  ),
  title: NotificationTitle.fromJson(json['title'] as Map<String, dynamic>),
  content: NotificationContent.fromJson(
    json['content'] as Map<String, dynamic>,
  ),
  description: NotificationDescription.fromJson(
    json['description'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$NotificationEntryLocalResponseToJson(
  _NotificationEntryLocalResponse instance,
) => <String, dynamic>{
  'notificationId': const NotificationIdConverter().toJson(
    instance.notificationId,
  ),
  'sourceId': instance.sourceId,
  'userId': instance.userId,
  'notificationDateTime': const NotificationDateConverter().toJson(
    instance.notificationDateTime,
  ),
  'title': instance.title,
  'content': instance.content,
  'description': instance.description,
};
