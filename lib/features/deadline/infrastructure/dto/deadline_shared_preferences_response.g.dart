// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deadline_shared_preferences_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeadlineSharedPreferencesResponse _$DeadlineSharedPreferencesResponseFromJson(
  Map<String, dynamic> json,
) => _DeadlineSharedPreferencesResponse(
  isEnabled: json['isEnabled'] as bool,
  hour: (json['hour'] as num).toInt(),
  minute: (json['minute'] as num).toInt(),
);

Map<String, dynamic> _$DeadlineSharedPreferencesResponseToJson(
  _DeadlineSharedPreferencesResponse instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'hour': instance.hour,
  'minute': instance.minute,
};
