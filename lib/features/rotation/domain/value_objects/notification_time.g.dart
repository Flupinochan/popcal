// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationTime _$NotificationTimeFromJson(Map<String, dynamic> json) =>
    _NotificationTime(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
    );

Map<String, dynamic> _$NotificationTimeToJson(_NotificationTime instance) =>
    <String, dynamic>{'hour': instance.hour, 'minute': instance.minute};
