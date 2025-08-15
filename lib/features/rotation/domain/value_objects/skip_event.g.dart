// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skip_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkipEvent _$SkipEventFromJson(Map<String, dynamic> json) => _SkipEvent(
  dateKey: DateKey.fromJson(json['dateKey'] as Map<String, dynamic>),
  dayType: $enumDecode(_$DayTypeEnumMap, json['dayType']),
  skipCount: SkipCount.fromJson(json['skipCount'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SkipEventToJson(_SkipEvent instance) =>
    <String, dynamic>{
      'dateKey': instance.dateKey,
      'dayType': _$DayTypeEnumMap[instance.dayType]!,
      'skipCount': instance.skipCount,
    };

const _$DayTypeEnumMap = {
  DayType.notRotationDay: 'notRotationDay',
  DayType.rotationDay: 'rotationDay',
  DayType.skipToNext: 'skipToNext',
  DayType.holiday: 'holiday',
};
