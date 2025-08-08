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
  rotationId: const RotationIdConverter().fromJson(
    json['rotationId'] as String,
  ),
  userId: UserId.fromJson(json['userId'] as String),
  notificationDate: const NotificationDateConverter().fromJson(
    json['notificationDate'] as String,
  ),
  rotationName: const RotationNameConverter().fromJson(
    json['rotationName'] as String,
  ),
  memberName: const RotationMemberNameConverter().fromJson(
    json['memberName'] as String,
  ),
  title: json['title'] as String,
  description: json['description'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$NotificationEntryLocalResponseToJson(
  _NotificationEntryLocalResponse instance,
) => <String, dynamic>{
  'notificationId': const NotificationIdConverter().toJson(
    instance.notificationId,
  ),
  'rotationId': const RotationIdConverter().toJson(instance.rotationId),
  'userId': instance.userId,
  'notificationDate': const NotificationDateConverter().toJson(
    instance.notificationDate,
  ),
  'rotationName': const RotationNameConverter().toJson(instance.rotationName),
  'memberName': const RotationMemberNameConverter().toJson(instance.memberName),
  'title': instance.title,
  'description': instance.description,
  'content': instance.content,
};
