// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deadline_shared_preferences_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeadlineSharedPreferencesResponse _$DeadlineSharedPreferencesResponseFromJson(
  Map<String, dynamic> json,
) => _DeadlineSharedPreferencesResponse(
  isEnabled: json['isEnabled'] as bool,
  notificationTime: NotificationTime.fromJson(
    json['notificationTime'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DeadlineSharedPreferencesResponseToJson(
  _DeadlineSharedPreferencesResponse instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'notificationTime': instance.notificationTime,
};
